#!/bin/bash

set -e

SCRIPT_NAME=$(basename "$0")
OVERLAY_DEFAULT="overlay.ps"

usage() {
  echo "Usage: $SCRIPT_NAME [OPTIONS] input.pdf [overlay.ps]"
  echo ""
  echo "Impose an 8-page PDF as a print-ready zine on a single letter-sized sheet."
  echo "Overwrites previous output."
  echo ""
  echo "Arguments:"
  echo "  input.pdf         Input PDF with 8 pages at 2.75\" x 4.25\""
  echo "  overlay           Overlay PostScript file (default: overlay.ps, pass \"\" to skip)"
  echo ""
  echo "Options:"
  echo "  --clean           Remove intermediate files after a successful run"
  echo "  --clean-only      Remove intermediate files from a previous run and exit"
  echo "  --help            Show this help message"
  exit 0
}

CLEAN=false
CLEAN_ONLY=false
INPUT=""
OVERLAY="$OVERLAY_DEFAULT"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --help) usage ;;
    --clean) CLEAN=true; shift ;;
    --clean-only) CLEAN_ONLY=true; shift ;;
    -*)
      echo "Unknown option: $1" >&2
      echo "Run '$SCRIPT_NAME --help' for usage." >&2
      exit 1
      ;;
    *)
      if [[ -z "$INPUT" ]]; then
        INPUT="$1"
      else
        OVERLAY="$1"
      fi
      shift
      ;;
  esac
done

# Derive base name and temp dir from input filename
INPUT_BASE="${INPUT%.pdf}"
INPUT_BASE=$(basename "$INPUT_BASE")
TMPDIR="zineify_tmp_${INPUT_BASE}"

# --clean-only mode
if $CLEAN_ONLY; then
  if [[ -d "$TMPDIR" ]]; then
    rm -rf "$TMPDIR"
    echo "Removed $TMPDIR"
  else
    echo "No temp directory found for '$INPUT_BASE' (looked for $TMPDIR)"
  fi
  exit 0
fi

# Validate input
if [[ -z "$INPUT" ]]; then
  echo "Error: No input file specified." >&2
  echo "Run '$SCRIPT_NAME --help' for usage." >&2
  exit 1
fi

if [[ ! -f "$INPUT" ]]; then
  echo "Error: Input file not found: $INPUT" >&2
  exit 1
fi

OUTPUT="${INPUT_BASE}_zineified.pdf"
SCALE=0.95

mkdir -p "$TMPDIR"

trap 'echo ""; echo "Something went wrong. Intermediate files are in: $TMPDIR"; exit 1' ERR

echo "Converting $INPUT to PostScript..."
pdf2ps "$INPUT" "$TMPDIR/converted.ps"

echo "Imposing pages..."
pstops "8:\
1L@${SCALE}(8.25in,0.25in)+\
0R@${SCALE}(0.25in,2.365in)+\
2L@${SCALE}(8.25in,3.0in)+\
7R@${SCALE}(0.25in,5.165in)+\
3L@${SCALE}(8.25in,5.75in)+\
6R@${SCALE}(0.25in,7.865in)+\
4L@${SCALE}(8.25in,8.5in)+\
5R@${SCALE}(0.25in,10.615in)" \
"$TMPDIR/converted.ps" "$TMPDIR/imposed.ps"

echo "Converting to PDF..."
ps2pdf "$TMPDIR/imposed.ps" "$TMPDIR/imposed.pdf"

if [[ -n "$OVERLAY" ]]; then
  if [[ ! -f "$OVERLAY" ]]; then
    echo "Error: Overlay file not found: $OVERLAY" >&2
    exit 1
  fi
  echo "Applying overlay..."
  ps2pdf -g7920x6120 "$OVERLAY" "$TMPDIR/overlay.pdf"
  pdftk "$TMPDIR/imposed.pdf" stamp "$TMPDIR/overlay.pdf" output "$OUTPUT"
else
  cp "$TMPDIR/imposed.pdf" "$OUTPUT"
fi

if $CLEAN; then
  rm -rf "$TMPDIR"
else
  echo "Intermediate files are in: $TMPDIR"
fi

echo "Done: $OUTPUT"