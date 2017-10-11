% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jorge Alexander
% - - - - - - 


%%
%- - - - - - 
%Exercise 4: Managing different size and filters
%- - - - - - 

% loss of details on resize  
corals = imread('images/corals.jpg');
re_corals = imresize(corals, 0.25);
subplot(1,2,1), imshow(corals);
subplot(1,2,2), imshow(re_corals);

% Histograms
subplot(2,2,1), imshow(corals);
subplot(2,2,2), imhist(corals);
subplot(2,2,3), imshow(re_corals);
subplot(2,2,4), imhist(re_corals);

% Note: We observe that the histogram of the resized image has a much lower
% intensity of the greyscale values. For example, at around 50 the rescaled
% image has an intensity of 400, whereas the original had an intensity of
% 0.5*10^4 (5000). The scaled image has an intensity ~ 10X lower than the
% original. With the higher intensity, the original image has a better
% defined distribution greyscale, where as the resized image has a more
% jagged distribution.

% Scale back up
re_corals = imresize(re_corals, 4);
imshow(re_corals);
% Note: here we see that even though the image is now the same size as the
% original again, the definition is still lost.









