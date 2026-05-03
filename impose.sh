#!/bin/bash

# Convert the input pdf to ps
pdf2ps ${1} converted.ps
# scale down to stay in the printable area
SCALE=0.95

# Imposition
pstops "8:\
1L@${SCALE}(8.25in,0.25in)+\
0R@${SCALE}(0.25in,2.365in)+\
2L@${SCALE}(8.25in,3.0in)+\
7R@${SCALE}(0.25in,5.165in)+\
3L@${SCALE}(8.25in,5.75in)+\
6R@${SCALE}(0.25in,7.865in)+\
4L@${SCALE}(8.25in,8.5in)+\
5R@${SCALE}(0.25in,10.615in)" \
converted.ps imposed.ps

# Convert back to pdf
ps2pdf imposed.ps

# Convert the overlay to pdf
ps2pdf -g7920x6120 overlay.ps overlay.pdf

# Overlay them atop one another
pdftk imposed.pdf stamp overlay.pdf output final.pdf
