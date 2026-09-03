#!/bin/bash

# ─────────────────────────────────────────
# Avatar Frame Extractor + Background Remover
# Usage: ./create_frames <video_file>
# ─────────────────────────────────────────

set -e

VIDEO=$1

# ── Argument Check ──────────────────────
if [ -z "$VIDEO" ]; then
    echo "Usage: $0 <video_file>"
    exit 1
fi

if [ ! -f "$VIDEO" ]; then
    echo "Error: Video file '$VIDEO' not found."
    exit 1
fi

# ── Dependency Check ────────────────────
echo "Checking dependencies..."

if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed."
    echo "Install it with: sudo dnf install ffmpeg"
    exit 1
fi

if ! command -v rembg &> /dev/null; then
    echo "Error: rembg is not installed."
    echo "Install it with: pip install rembg"
    exit 1
fi

if ! command -v mogrify &> /dev/null; then
    echo "Error: imagemagick is not installed."
    echo "Install it with: sudo dnf install ImageMagick"
    exit 1
fi

echo "✓ ffmpeg found: $(ffmpeg -version 2>&1 | head -n1)"
echo "✓ rembg found: $(rembg --version 2>&1)"
echo "✓ imagemagick found"

# ── Interactive Prompts ─────────────────
echo ""
read -p "frame count (default: 12): " FPS
FPS=${FPS:-12}

read -p "output dir (default: frames): " OUTPUT_DIR
OUTPUT_DIR=${OUTPUT_DIR:-frames}

read -p "action name (default: idle): " ACTION
ACTION=${ACTION:-idle}

read -p "loop animation? (y/n, default: y): " LOOP
LOOP=${LOOP:-y}

read -p "create spritesheet? (y/n): " CREATE_SHEET

# ── Fixed Settings ───────────────────────
# 4:3 aspect for 1280x960
# FRAME_WIDTH=533
# FRAME_HEIGHT=400
FRAME_WIDTH=640
FRAME_HEIGHT=480
COLS=4
FRAMES_PER_SHEET=32

if [ "$CREATE_SHEET" = "y" ]; then
    echo ""
    echo "Spritesheet settings:"
    echo "  Frame size: ${FRAME_WIDTH}x${FRAME_HEIGHT}px"
    echo "  Grid: ${COLS} columns"
    echo "  Frames per sheet: ${FRAMES_PER_SHEET}"
    echo "  Sheet dimensions: $((FRAME_WIDTH * COLS))x$((FRAME_HEIGHT * 8))px (approx)"
fi

# ── Setup Directories ───────────────────
RAW_DIR="$HOME/projects/hervis/windows/assets/frames/$OUTPUT_DIR/raw"
FINAL_DIR="$HOME/projects/hervis/windows/assets/frames/$OUTPUT_DIR"
SHEET_DIR="$HOME/projects/hervis/windows/assets/frames/$OUTPUT_DIR/sheets"

mkdir -p "$RAW_DIR"
mkdir -p "$FINAL_DIR"

# ── Step 1: Extract Frames ───────────────
echo ""
echo "Extracting frames at ${FPS}fps from '$VIDEO'..."

ffmpeg -i "$VIDEO" -r "$FPS" "$RAW_DIR/frame_%04d.png" -hide_banner -loglevel error

RAW_COUNT=$(ls "$RAW_DIR" | wc -l)
echo "✓ Extracted $RAW_COUNT frames."

# ── Step 2: Remove Background ────────────
echo ""
echo "Removing backgrounds (this may take a while)..."

rembg p "$RAW_DIR" "$FINAL_DIR"

FINAL_COUNT=$(ls "$FINAL_DIR"/*.png 2>/dev/null | wc -l)
echo "✓ Processed $FINAL_COUNT frames → '$FINAL_DIR'"

# ── Step 3: Spritesheet ──────────────────
if [ "$CREATE_SHEET" = "y" ]; then
    echo ""
    echo "Resizing frames to ${FRAME_WIDTH}x${FRAME_HEIGHT}..."

    mogrify -resize "${FRAME_WIDTH}x${FRAME_HEIGHT}!" \
        -background none \
        -alpha set \
        "$FINAL_DIR/frame_"*.png

    echo "✓ All frames resized to ${FRAME_WIDTH}x${FRAME_HEIGHT}px"

    mkdir -p "$SHEET_DIR"

    FRAMES=("$FINAL_DIR"/frame_*.png)
    TOTAL=${#FRAMES[@]}
    SHEET_INDEX=1
    SHEET_FILES=()

    echo ""
    echo "Packing spritesheets ($FRAMES_PER_SHEET frames per sheet)..."

    for (( i=0; i<TOTAL; i+=FRAMES_PER_SHEET )); do
        BATCH=("${FRAMES[@]:$i:$FRAMES_PER_SHEET}")
        BATCH_COUNT=${#BATCH[@]}
        ROWS=$(( (BATCH_COUNT + COLS - 1) / COLS ))
        SHEET_NAME=$(printf "spritesheet_%03d.png" $SHEET_INDEX)

        SHEET_WIDTH=$((FRAME_WIDTH * COLS))
        SHEET_HEIGHT=$((FRAME_HEIGHT * ROWS))

        echo "  → $SHEET_NAME ($BATCH_COUNT frames, ${COLS}x${ROWS} grid = ${SHEET_WIDTH}x${SHEET_HEIGHT}px)"

        montage "${BATCH[@]}" \
            -tile "${COLS}x${ROWS}" \
            -geometry +0+0 \
            -background none \
            -alpha set \
            "$SHEET_DIR/$SHEET_NAME"

        SHEET_FILES+=("{\"file\": \"$SHEET_NAME\", \"frames\": $BATCH_COUNT, \"cols\": $COLS, \"rows\": $ROWS}")
        SHEET_INDEX=$(( SHEET_INDEX + 1 ))
    done

    # ── Generate Manifest ────────────────
    LOOP_VAL="true"
    [ "$LOOP" != "y" ] && LOOP_VAL="false"

    SHEETS_JSON=$(IFS=,; echo "${SHEET_FILES[*]}")

    cat > "$SHEET_DIR/manifest.json" <<EOF
{
    "action": "$ACTION",
    "fps": $FPS,
    "loop": $LOOP_VAL,
    "total_frames": $TOTAL,
    "frame_width": $FRAME_WIDTH,
    "frame_height": $FRAME_HEIGHT,
    "frames_per_sheet": $FRAMES_PER_SHEET,
    "sheets": [
        $SHEETS_JSON
    ]
}
EOF

    echo ""
    echo "✓ Manifest saved to: $SHEET_DIR/manifest.json"
    echo "✓ Total sheets created: $(( SHEET_INDEX - 1 ))"

    TOTAL_SHEETS=$(( SHEET_INDEX - 1 ))
    echo ""
    echo "Summary:"
    echo "  Frame size: ${FRAME_WIDTH}x${FRAME_HEIGHT}px"
    echo "  Frames per sheet: ${FRAMES_PER_SHEET} (${COLS} columns)"
    echo "  Number of sheets: $TOTAL_SHEETS"
fi

# ── Step 4: Cleanup Raw Frames ───────────
echo ""
read -p "Delete raw frames to save space? (y/n): " CLEANUP
if [ "$CLEANUP" = "y" ]; then
    rm -rf "$RAW_DIR"
    echo "✓ Raw frames deleted."
else
    echo "→ Raw frames kept at '$RAW_DIR'."
fi

# ── Done ─────────────────────────────────
echo ""
echo "═══════════════════════════════════════"
echo "✓ Done!"
echo "═══════════════════════════════════════"
echo "Frames: $FINAL_DIR"
[ "$CREATE_SHEET" = "y" ] && echo "Sheets: $SHEET_DIR"
echo "═══════════════════════════════════════"
