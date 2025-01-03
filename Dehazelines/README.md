Using Standard dark channel equation to restore the image by finding 2 attenuation ratios of color channels with respect to blue channel.
In standard dcp equation artificial light is found based on darkest pixel or 0.1% darkest pixel of the image, whereas in Dehazelines it is found by taking average of pixels largest component(which is veiling light) of edge map constructedusing structed edge detection toolbox.
Attenuation ratios are found w.r.t blue color channel which varies based on the water type and reduced to single image dehazing problem to get the restored image.

This code is taken from below paper:
@inproceedings{Berman2017DivingIH,
  title={Diving into Haze-Lines: Color Restoration of Underwater Images},
  author={Dana Berman and Shai Avidan},
  year={2017},
  url={https://api.semanticscholar.org/CorpusID:34706534}
}
