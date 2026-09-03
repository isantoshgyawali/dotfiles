// My taste for working with sqlc types in typescript
// This tool processes all .ts files under app/utils/db (recursively).
// For each file it:
//  1. Extracts only the "export interface Name { ... }" blocks
//  2. Overwrites the file with just those interfaces
//  3. Renames any file ending in _sql.ts to .d.ts
//
// Useful after running sqlc-gen-typescript so that the generated
// files become clean declaration files containing only the type
// definitions you need.
//
// Usage:
//	go build format-sqlc-gen-typescript.go
//	./format-sqlc-gen-typescript
package main

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

const ROOT_DIR = "app/utils/db"

var interfaceRegex = regexp.MustCompile(`(?s)export\s+interface\s+\w+\s*\{.*?\}`)

func processFile(filePath string) error {
	// Read file
	data, err := os.ReadFile(filePath)
	if err != nil {
		return err
	}

	source := string(data)

	// Find all exported interfaces
	matches := interfaceRegex.FindAllString(source, -1)

	// Build new content
	var output string
	if len(matches) > 0 {
		output = strings.Join(matches, "\n\n") + "\n"
	} else {
		output = ""
	}

	// Write back (overwrite)
	if err := os.WriteFile(filePath, []byte(output), 0644); err != nil {
		return err
	}

	// Rename _sql.ts → .d.ts
	if strings.HasSuffix(filepath.Base(filePath), "_sql.ts") {
		dir := filepath.Dir(filePath)
		base := filepath.Base(filePath)
		newName := strings.Replace(base, "_sql.ts", ".d.ts", 1)
		newPath := filepath.Join(dir, newName)

		if newPath != filePath {
			if err := os.Rename(filePath, newPath); err != nil {
				return err
			}
			fmt.Printf("Renamed: %s → %s\n", filePath, newPath)
		}
	}

	return nil
}

func walkDir(dir string) error {
	return filepath.WalkDir(dir, func(path string, d os.DirEntry, err error) error {
		if err != nil {
			return err
		}

		if d.IsDir() {
			return nil // continue walking
		}

		if strings.HasSuffix(d.Name(), ".ts") {
			fmt.Printf("Processing: %s\n", path)
			if err := processFile(path); err != nil {
				fmt.Printf("Error processing %s: %v\n", path, err)
			}
		}
		return nil
	})
}

func main() {
	fmt.Println("Starting TypeScript interface extractor (Go version)...")
	fmt.Printf("Root directory: %s\n\n", ROOT_DIR)

	if _, err := os.Stat(ROOT_DIR); os.IsNotExist(err) {
		fmt.Printf("Error: Directory '%s' not found!\n", ROOT_DIR)
		os.Exit(1)
	}

	if err := walkDir(ROOT_DIR); err != nil {
		fmt.Printf("Error walking directory: %v\n", err)
		os.Exit(1)
	}

	fmt.Println("\n✅ Done! All .ts files processed.")
}
