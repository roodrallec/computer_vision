% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Emer Rodriguez Formisano and Jorge Alexander
% - - - - - - 


%%
%- - - - - - 
%Exercise 4: Managing different size and filters
%- - - - - - 
% 1. reading the image file
CORALS = imread('images/corals.jpg');

% 2. loss of details on resize  
reCorals = imresize(CORALS, 0.25);
subplot(1,2,1), imshow(CORALS), title("Original");
subplot(1,2,2), imshow(reCorals), title("Resized");

% 3. Histograms
subplot(2,2,1), imshow(CORALS);
subplot(2,2,2), imhist(CORALS);
subplot(2,2,3), imshow(reCorals);
subplot(2,2,4), imhist(reCorals);
% Comment: We observe that the histogram of the resized image has a much lower
% intensity of the greyscale values. For example, at around 50 the rescaled
% image has an intensity of 400, whereas the original had an intensity of
% 0.5*10^4 (5000). The scaled image has an intensity ~ 10X lower than the
% original. With the higher intensity, the original image has a better
% defined distribution greyscale, where as the resized image has a more
% jagged distribution.

% Emer: not sure about your comment above. The histogram shows the
% frequency of pixels for each level of intensity. The scaled down image
% has less pixels, so the counts (absolute freq.) will be lower.  
% We should compare the shape and if we want to plot it, then rescaled to
% desnity (relative freq.) is required.
coralsN = imhist(CORALS);
reCoralsN = imhist(reCorals);
figure
plot([coralsN/sum(coralsN) reCoralsN/sum(reCoralsN)], 'LineWidth',2);
legend('Original','Scaled 0.25')
xlabel('Intensity'), ylabel('Relative Frequency'), title('Image Histogram')
% Commet: both lines are very close to each other which means that scaling the
% image down do not affect the intensity distribution of the image.

% 4. Scale back up
reCorals = imresize(reCorals, 4);
imshow(reCorals);
% Comment: here we see that even though the image is now the same size as the
% original again, the definition (information) is still lost.

% 5. Filtering
VECTOR_FILTER = ones(1,3);
filterCorals = imfilter(CORALS, VECTOR_FILTER);
gaussFilterCorals = imgaussfilt(CORALS,2);
% plotting the images against the original
subplot(1,3,1), imshow(CORALS), title("Original");
subplot(1,3,2), imshow(filterCorals), title("Vector filter: [1 1 1]");
subplot(1,3,3), imshow(gaussFilterCorals), title("Gaussian filter: \sigma = 2");
% Comment: here we see that USER_DEFINED_FILTER has made the image brighter and has
% lost definition (for example the lines can no longer be seen on the fish)
% As the vector is not normalised, the mask modifies the pixels by adding
% the value of the left and right pixels for each channel. Thus, the
% value for each pixel is increased making a whiten and slighlty blur image.   
% The gaussian filter has not made the image brighter as the weights are normalised,
% but has only blurred the image so we can neither see the lines on the fish.
openfig("figure4_5.fig")

% Increasing the size will make the in the mask vector, will make it whiter
% and more blurred by using only pixels in the horizontal axis. In other
% hand, increasing the value of sigma, the wider the gaussian distribution 
% will be, which takes further pixels (more information). As a result, the
% image will be blurrer with  better image choerence as the bell shape of 
% the weights reflects the idea that the pixels sourranding to the central 
% pixel are more relavant than further away pixels.
LARGER_VECTOR_FILTER = ones(1,30);
filterCorals = imfilter(CORALS, LARGER_VECTOR_FILTER);
gaussFilterCorals = imgaussfilt(CORALS,9);
% plotting the images against the original
subplot(1,3,1), imshow(CORALS), title("Original");
subplot(1,3,2), imshow(filterCorals), title("Vector filter: ones(1,30)");
subplot(1,3,3), imshow(gaussFilterCorals), title("Gaussian filter: \sigma = 9");

% 6. Filtering RGB
% Notes: Differences among CV functions
% https://es.mathworks.com/matlabcentral/answers/17529-what-is-the-difference-between-conv2-filter2-and-imfilter
% Correlation vs Convolution!
% https://camo.githubusercontent.com/91351c530d7b04be12fe0e8c3eda80412af5122c/68747470733a2f2f73616e646970616e7765622e66696c65732e776f726470726573732e636f6d2f323031372f30352f696d3131322e706e67
rgb = imread('3channels.jpg');

% JPG has lost definition, better to create it from scratch:
img1 = zeros([200, 200]);
img1(1:200,100:200) = 1;
img2 = zeros([200, 200]);
img2(100:200,1:200) = 1;
img3 = zeros([200, 200]);
img3(1:100,1:100) = 1;
img3 = zeros([200, 200]);
img3(1:100,1:100) = 1;
rgb = cat(3, img1, img2, img3);
gray = rgb2gray(rgb);

filterRgbCorr = imfilter(rgb, LARGER_VECTOR_FILTER, "corr");
filterRgbConv = imfilter(rgb, LARGER_VECTOR_FILTER, "conv");
filterGrayCorr = imfilter(gray, LARGER_VECTOR_FILTER, "corr");
filterGrayConv = imfilter(gray, LARGER_VECTOR_FILTER, "conv");
subplot(2,3,1), imshow(rgb), title("Original RGB");
subplot(2,3,2), imshow(filterRgbCorr), title("RBG Correlation Filter: ones(1,30)");
subplot(2,3,3), imshow(filterRgbConv), title("RGB Convolution Filter: ones(1,30)");
subplot(2,3,4), imshow(gray), title("Original Gray");
subplot(2,3,5), imshow(filterGrayCorr), title("Gray Correlation Filter: ones(1,30)");
subplot(2,3,6), imshow(filterGrayConv), title("Gray Convolution Filter: ones(1,30)");
% You can filter the RGB image. The Gray scale image 
% The mask should have the same dimensions as the image, one for each color

% 7.
% What is the difference using the following three masks: 
% [1 1 1 1 1], 
% Convolving with this will make each element in the matrix the sum of
% itself, and up to 2 elements before it and 2 elements after it horizontally.
% 
% [1;1;1;1;1]
% Convolving with this will make each element in the matrix the sum of
% itself,and up to 2 elements above it and 2 elements below it vertically.
% 
% [[1 1 1 1 1]; 
% [1 1 1 1 1]; 
% [1 1 1 1 1]; 
% [1 1 1 1 1]; 
% [1 1 1 1 1]]
% Convolving with this mask will make each element in the matrix the s the sum
% of all the other values covered by the mask (including itself) when the
% mask is placed with the element at the centre of it
% 
% Do we need to normalize the mask (divide by the sum of all its numbers)?
% Well the some of the weights affects the overall intensity of the ouput
% image, so we can normalise the weights of the mask so that they sum to
% one so that we dont affect the intensity of the image as much
maskA = [1 1 1 1 1]/5;
maskB = [1;1;1;1;1]/5;
maskC = [[1 1 1 1 1]; [1 1 1 1 1]; [1 1 1 1 1]; [1 1 1 1 1]; [1 1 1 1 1]]/25;
subplot(1,4,1), imshow(CORALS), title("Original");
subplot(1,4,2), imshow(imfilter(CORALS, maskA)), title("Mask: [1 1 1 1 1]/5");
subplot(1,4,3), imshow(imfilter(CORALS, maskB)), title("Mask: [1;1;1;1;1]/5");
subplot(1,4,4), imshow(imfilter(CORALS, maskC)), title("Mask: [[1 1 1 1 1]; ... /25");

% 8.Apply the filter several times in order to observe the effects 
onceFiltered = imfilter(CORALS, VECTOR_FILTER);
twiceFiltered = imfilter(onceFiltered, VECTOR_FILTER);
thriceFiltered = imfilter(twiceFiltered, VECTOR_FILTER);
subplot(1,4,1), imshow(CORALS), title("Original");
subplot(1,4,2), imshow(onceFiltered), title("Filter x1");
subplot(1,4,3), imshow(twiceFiltered), title("Filter x2");
subplot(1,4,4), imshow(thriceFiltered), title("Filter x3");
% It gets witer due to applying the effect describe in 4.5 several times.

% 9. Subtract the original and smoothed images in order to illustrate the
% difference between them. Use subploit in order to show the original
% smooth and the difference image in the same figure
subplot(1,3,1), imshow(CORALS), title("Original");
subplot(1,3,2), imshow(onceFiltered), title("Filtered");
subplot(1,3,3), imshow(CORALS - onceFiltered), title("Original - Filtered");
% We see that in the image that is the difference between them, the lines
% of the image stand out more

