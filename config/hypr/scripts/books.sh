#!/bin/bash
#following pacakges are mandatory to use this script
# - sxiv
# - poppler-utils

shopt -s nullglob

# Check if sxiv is installed
if ! command -v sxiv &> /dev/null; then
    echo "Error: sxiv is not installed. Please install it using your package manager."
    exit 1
fi

# Check if poppler-utils is installed aspecifically checking for pdfimages)
if ! command -v pdftoppm &> /dev/null; then
    echo "Error: poppler-utils is not installed. Please install it using your package manager."
    exit 1
fi

books_dir="$HOME/books/"
output_dir="$HOME/.cache/books_img/"

function extract_images() {
    for pdf in "$books_dir"*.pdf; do
        # extracts the base name of the pdf
        # which is later used to set the images name
        base_name=$(basename "$pdf" .pdf)
        output_cover_image="$output_dir$base_name"

        # cached and pdf unchanged: nothing to do
        [ "$output_cover_image.png" -nt "$pdf" ] && continue

        pdftoppm -png -singlefile -f 1 -l 1 \
            "$pdf" \
            "$output_cover_image"
    done

    # drop covers whose pdf was deleted
    for img in "$output_dir"*.png; do
        [ -f "$books_dir$(basename "$img" .png).pdf" ] || rm -f "$img"
    done
}

function select_book() {
    image_name=$(sxiv -to "$output_dir" | awk -F'/' '{print $NF}' | sed 's/\.png$//')
    echo "$image_name"

    for pdf in "$books_dir"*.pdf; do
        base_name=$(basename "$pdf" .pdf)
        if [ "$image_name" = "$base_name" ]; then
            zathura "$pdf"
        fi
    done
}

function main() {
    mkdir -p "$output_dir"
    extract_images
    select_book
}
main;
