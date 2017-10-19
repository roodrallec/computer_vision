% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jorge Alexander
% - - - - - - 


%%
%- - - - - - 
%Exercise 4: Managing different size and filters
%- - - - - - 
% 1. reading the image file
CORALS = imread('images/corals.jpg');

% 2. loss of details on resize  
reCorals = imresize(CORALS, 0.25);
subplot(1,2,1), imshow(CORALS);
subplot(1,2,2), imshow(reCorals);

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

% 4. Scale back up
reCorals = imresize(reCorals, 4);
imshow(reCorals);
% Comment: here we see that even though the image is now the same size as the
% original again, the definition is still lost.

% 5. Filtering
USER_DEFINED_FILTER = [[3 5 3];[1 6 1];[2 7 3]]/31;
filterCorals = imfilter(CORALS, USER_DEFINED_FILTER);
gaussFilterCorals = imgaussfilt(CORALS,2);
% plotting the images against the original
subplot(1,3,1), imshow(CORALS);
subplot(1,3,2), imshow(filterCorals);
subplot(1,3,3), imshow(gaussFilterCorals);
% Comment: here we see that filter_1 has made the image brighter and has
% lost definition (for example the lines can no longer be seen on the fish)
% The gaussian filter has not made the image brighter, but has blurred the
% image so we can neither see the lines on the fish.
% Different sized filters:
smallFilter = imfilter(CORALS, ones(1));
mediumFilter = imfilter(CORALS, ones(10));
largeFilter = imfilter(CORALS, ones(100));
subplot(1,3,1), imshow(smallFilter);
subplot(1,3,2), imshow(mediumFilter);
subplot(1,3,3), imshow(largeFilter);
% Comment: the larger the ones filter, the more intense effect it has, in
% this case the brighter the image becomes.
smallGauss = imgaussfilt(CORALS,1);
mediumGauss = imgaussfilt(CORALS,10);
largeGauss = imgaussfilt(CORALS,100);
subplot(1,3,1), imshow(smallGauss);
subplot(1,3,2), imshow(mediumGauss);
subplot(1,3,3), imshow(largeGauss);
% Comment: like the previous filter, the larger the gauss filter, the more
% intense the blur on the image. This is because the information in the
% image is being multiplied by a larger value.

% 6. Filtering RGB
rgb = imread('3channels.jpg');
filterRgb = imfilter(rgb, USER_DEFINED_FILTER, "conv");
subplot(1,2,1), imshow(rgb);
subplot(1,2,2), imshow(filterRgb);
% You can filter the RGB image
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
subplot(1,3,1), imshow(imfilter(CORALS, maskA));
subplot(1,3,2), imshow(imfilter(CORALS, maskB));
subplot(1,3,3), imshow(imfilter(CORALS, maskC));

% 8.Apply the filter several times in order to observe the effects 
onceFiltered = imfilter(CORALS, USER_DEFINED_FILTER);
twiceFiltered = imfilter(onceFiltered, USER_DEFINED_FILTER);
thriceFiltered = imfilter(twiceFiltered, USER_DEFINED_FILTER);
subplot(1,3,1), imshow(onceFiltered);
subplot(1,3,2), imshow(twiceFiltered);
subplot(1,3,3), imshow(thriceFiltered);
% It gets blurrier and detail is lost as it is filtered more
% times

% 9. Subtract the original and smoothed images in order to illustrate the
% difference between them. Use subploit in order to show the original
% smooth and the difference image in the same figure
subplot(1,3,1), imshow(CORALS);
subplot(1,3,2), imshow(onceFiltered);
subplot(1,3,3), imshow(CORALS - onceFiltered);
% We see that in the image that is the difference between them, the lines
% of the image stand out more

