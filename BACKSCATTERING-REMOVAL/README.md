# BACKSCATTERING-REMOVAL
1. Given image is divided into reflectance and illumination components.
2. From the illumiation compoenent background light and transmission map are estimated.
  - transmission map is obtained by refinement and enhancement on each color channel
3. Reflectance component is color corrected to prevent color distortion.
4. At last illuminance and reflectance component are fused to give output image.
  - fusion process is carried out by taking gaussian and laplacian filters on the weights of illuminance and reflectance compoenents obtained.
5. For more information  refer:
@misc{
	10356_68950,
	author = {Hao Zhang},
	title = {Removing backscatter to enhance the visibility of underwater object},
	year = {2016},
	abstract = {Underwater vision enhancement via backscatter removing is widely used in ocean engineering. With increasing ocean exploration, underwater image processing has drawn more and more attention due to the important roles of video and image for obtain information. However, due to the existence of dust-like particles and light attenuation, underwater images and videos always suffer from the problems of low contrast and color distortion. In this thesis, we analyze the underwater light propagation process and propose an effective method to overcome the backscatter problem. Our method is based on the underwater optical model and image fusion. It mainly contains three steps, first, we decompose input image into reflectance and illuminance components; second, we utilize color correction technology and dehazing technology to handle these two components separately; finally, in order to rebuild result well, we applied the Gaussian and Laplacian pyramids based multi-scale fusion to reconstruct the target image while exposedness, saliency maps are utilized as weights to assist the fusion task. The experimental results show that our proposed method is able to greatly improve the quality of distorted underwater images. By introducing the underwater image quality metric measurements, we also analyze the intrinsic information and objective feature indexes of restored images via different methods. In general, our proposed method outperforms state of the art among sets of test images captured in different water environments and is demonstrated to be well-performed and effective.},
}
