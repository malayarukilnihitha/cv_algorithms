# Multiscale retinex with color restoration

## Description
Python implementation of multiscale retinex color restoration with automation.

1. Proposed method chooses upper and lower clipping points.
2. The frequency of occurrence of pixel value '0’ in the enhanced image will be found. The lower and upper clipping points are obtained accordingly; y=0.05 is found to be an optimum value for most of the images by doing like this(clipping) 5 percent of pixels on either side of the histogram are discarded.
