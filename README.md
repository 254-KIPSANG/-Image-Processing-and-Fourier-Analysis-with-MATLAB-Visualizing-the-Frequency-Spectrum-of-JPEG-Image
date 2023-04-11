# -Image-Processing-and-Fourier-Analysis-with-MATLAB-Visualizing-the-Frequency-Spectrum-of-JPEG-Image
Image Processing Pipeline This code reads in all .jpg files in the current directory, applies a series of preprocessing steps to each image, and displays the original images along with the corresponding processed images using a slider.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
KINDLY PAY ATTENTION TO LIKING AND FOLLOWING ME ON MATLAB @cyrus kipsang
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Reading Image Files
The first step of the pipeline is to read in all .jpg files in the current directory and store them in a cell array. This is achieved using the dir function to get a list of all .jpg files, and then looping over each file and reading it in using the imread function. If an image is RGB, it is converted to grayscale using the rgb2gray function.

Preprocessing
The next step of the pipeline is to preprocess each image to remove noise and enhance contrast. This is done using a series of image processing functions:

Median filtering: This is a nonlinear filtering operation that replaces each pixel in the image with the median value of its neighborhood. Median filtering is commonly used to remove salt-and-pepper noise from images. In this code, we apply median filtering to each image using the medfilt2 function with a 3x3 neighborhood.
Morphological opening: This is an operation that removes small objects from the foreground of an image while preserving the larger structures. In this code, we apply morphological opening to each image using the imopen function with a disk-shaped structuring element of radius 10 pixels.
Background subtraction: We subtract the background obtained from morphological opening from each image to obtain the foreground. This is done using the - operator.
Histogram equalization: This is a technique for enhancing the contrast of an image by redistributing the pixel intensities. Histogram equalization maps the image histogram to a uniform distribution. In this code, we apply histogram equalization to each image using the histeq function.
Fourier Transform
The next step of the pipeline is to compute the Fourier transform of each image. The Fourier transform is a mathematical operation that decomposes a signal (in this case, an image) into its frequency components. The Fourier transform of a 2D image is a complex-valued function, which can be represented as a magnitude and phase component.

In this code, we compute the Fourier transform of each preprocessed image using the fft2 function. This function returns the complex-valued Fourier transform, which is then split into its magnitude and phase components using the abs and angle functions, respectively.

Power Spectrum
The power spectrum of an image is the squared magnitude of its Fourier transform. The power spectrum represents the distribution of frequency content in the image, with higher values indicating higher frequencies. In this code, we compute the power spectrum of each Fourier transform using the abs and fftshift functions. The fftshift function shifts the zero-frequency component of the Fourier transform to the center of the spectrum.

Log Power Spectrum
The log power spectrum is obtained by taking the logarithm of the power spectrum. The log power spectrum is often used for visualization, as it compresses the dynamic range of the spectrum and enhances the visibility of small features. In this code, we compute the log power spectrum of each power spectrum using the log10 function, with a small number eps added to avoid taking the logarithm of zero.

Displaying Images
The final step of the pipeline is to display the original images and the corresponding processed images in a figure with a slider. This is done using the figure and axes functions to create a figure and an axes object, respectively. We also create a slider using the uicontrol function, which allows the user to navigate through the images.

The update_slider function is called whenever the slider value changes. This function updates the displayed image and the processed images based on the current slider value. The processed
