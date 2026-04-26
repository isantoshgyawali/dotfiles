#!/bin/sh
#following pacakges are mandatory to use this script
# - sxiv
# - poppler-utils

# Check if sxiv is installed
if ! command -v sxiv &> /dev/null; then
    echo "Error: sxiv is not installed. Please install it using your package manager."
    exit 1
fi

# Check if poppler-utils is installed aspecifically checking for pdfimages)
if ! command -v pdfimages &> /dev/null; then
    echo "Error: poppler-utils is not installed. Please install it using your package manager."
    exit 1
fi

books_dir="$HOME/books/"
output_dir="/tmp/books_img/"

function extract_images() {
    for pdf in "$books_dir"*.pdf; do 
        # extracts the base name of the pdf
        # which is later used to set the images name
        base_name=$(basename "$pdf" .pdf)
        output_cover_image="$output_dir/$base_name"

        pdftoppm -f 1 -l 1 \
            "$pdf" \
            "$output_cover_image"
        done 
    }

function select_book() {
    image_name=$(sxiv -to $output_dir | awk -F'/' '{print $NF}' | sed 's/-[0-9]*\.ppm$//')
    echo $image_name

    for pdf in "$books_dir"*.pdf; do 
        base_name=$(basename "$pdf" .pdf)
        if [ "$image_name" = "$base_name" ]; then 
            rm -rf $output_dir
            zathura "$pdf"
        fi     
    done 
}

function main() {
    mkdir -p $output_dir
    extract_images
    select_book
}
main;
