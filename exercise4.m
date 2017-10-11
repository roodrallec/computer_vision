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
corals = imread('images/corals.jpg');

% 2. loss of details on resize  
re_corals = imresize(corals, 0.25);
subplot(1,2,1), imshow(corals);
subplot(1,2,2), imshow(re_corals);

% 3. Histograms
subplot(2,2,1), imshow(corals);
subplot(2,2,2), imhist(corals);
subplot(2,2,3), imshow(re_corals);
subplot(2,2,4), imhist(re_corals);
% Comment: We observe that the histogram of the resized image has a much lower
% intensity of the greyscale values. For example, at around 50 the rescaled
% image has an intensity of 400, whereas the original had an intensity of
% 0.5*10^4 (5000). The scaled image has an intensity ~ 10X lower than the
% original. With the higher intensity, the original image has a better
% defined distribution greyscale, where as the resized image has a more
% jagged distribution.

% 4. Scale back up
re_corals = imresize(re_corals, 4);
imshow(re_corals);
% Comment: here we see that even though the image is now the same size as the
% original again, the definition is still lost.

% 5. Filtering
filter_1 = [1,1,1];
filter_1_corals = imfilter(corals, filter_1);
filter_gauss_corals = imgaussfilt(corals,2);
% plotting the images against the original
subplot(1,3,1), imshow(corals);
subplot(1,3,2), imshow(filter_1_corals);
subplot(1,3,3), imshow(filter_gauss_corals);
% Comment: here we see that filter_1 has made the image brighter and has
% lost definition (for example the lines can no longer be seen on the fish)
% The gaussian filter has not made the image brighter, but has blurred the
% image so we can neither see the lines on the fish.
% Different sized filters:
filter_1_small = imfilter(corals, ones(1));
filter_1_medium = imfilter(corals, ones(10));
filter_1_large = imfilter(corals, ones(100));
subplot(1,3,1), imshow(filter_1_small);
subplot(1,3,2), imshow(filter_1_medium);
subplot(1,3,3), imshow(filter_1_large);
% Comment: the larger the ones filter, the more intense effect it has, in
% this case the brighter the image becomes.
gauss_small = imgaussfilt(corals,1);
gauss_medium = imgaussfilt(corals,10);
gauss_large = imgaussfilt(corals,100);
subplot(1,3,1), imshow(gauss_small);
subplot(1,3,2), imshow(gauss_medium);
subplot(1,3,3), imshow(gauss_large);
% Comment: like the previous filter, the larger the gauss filter, the more
% intense the blur on the image. This is because the information in the
% image is being multiplied by a larger value.


