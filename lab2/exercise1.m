% - - - - - - 
% MAI CV
% Exercises Lab 2
% Author name: Jorge Alexander 
% - - - - - - 

%%
%- - - - - - 
%% Exercise 1: Determine the optimal edges
%- - - - - - 
% "Edge detection is an image processing technique for finding the 
% boundaries of objects within images. 
% It works by detecting discontinuities in brightness. 
% Edge detection is used for image segmentation and data extraction 
% in areas such as image processing, computer vision, and machine vision."
% - MathWorks Edge Detection documentation

% Read the image "starbuck.jpg" and find its edges using matlab function
% edge.
% Apply different operators (Sobel and Prewitt, Laplacian of Gaussian) and
% find the optimal parameters for each of them.
% Overlap the edges as in Fig.2
% Repeat the experiment on 3 other images.
for filename = {'./images_video/starbuck.jpg', './images_video/dog.jpg', './images_video/Einstein.jpg'}
    showedges(filename{1});
end
% "In all cases, edge chooses the default threshold heuristically, depending on the input data. 
% The best way to vary the threshold is to run edge once, capturing the calculated threshold as the second output argument. 
% Then, starting from the value calculated by edge, adjust the threshold
% higher (fewer edge pixels) or lower (more edge pixels)."
% - MathWorks edge function documentation

% % STARBUCK case study
STARBUCK = imread('./images_video/starbuck.jpg');
% Sobel
% threshold = []; % return all edges that are stronger than threshold
direction = 'both'; % specify the direction in which the function looks for edges in the image
thinning = 'nothinning'; % 'nothinning'; % specify whether to skip the additional edge-thinning stage
[sobel, threshold] = edge(STARBUCK(:,:,1), 'Sobel', [], direction, thinning);  % to get threshold value
sobel = edge(STARBUCK(:,:,1), 'Sobel', threshold, direction, thinning);
subplot(1,2,1), imshow(STARBUCK), title("Original image");
subplot(1,2,2), imshow(sobel), title("Processed image");
% Discontinuities are still observerd. the threshold is now decreased, in an
% attempt to make the edges more continuous:
threshold = threshold - 0.1; 
sobel = edge(STARBUCK(:,:,1), 'Sobel', threshold, direction, thinning);
subplot(1,2,1), imshow(STARBUCK), title("Original image");
subplot(1,2,2), imshow(sobel), title("Processed image");
% Although it is now observed that the edges of the letters are now
% continous, the edges of the stars are still not. The threshold is
% increased further:
threshold = threshold - 0.1; 
sobel = edge(STARBUCK(:,:,1), 'Sobel', threshold, direction, thinning);
subplot(1,2,1), imshow(STARBUCK), title("Original image");
subplot(1,2,2), imshow(sobel), title("Processed image");
% It is now observed that although the edge discontinuities have
% disappeared, the edges are much wider, and image detail is lost. The
% thinning parameter is now activated, in an attempt to make the edges
% thinner.
thinning = 'thinning';
sobel = edge(STARBUCK(:,:,1), 'Sobel', threshold, direction, thinning);
subplot(1,2,1), imshow(STARBUCK), title("Original image");
subplot(1,2,2), imshow(sobel), title("Processed image");
% The new processed image shows much clearer edges than the default value.
% However, there are other edge algorithms which may give better results:
% Prewitt
direction = 'both'; % specify the direction in which the function looks for edges in the image
thinning = 'nothinning'; % 'nothinning'; % specify whether to skip the additional edge-thinning stage
[prewitt, threshold] = edge(STARBUCK(:,:,1), 'Prewitt', [], direction, thinning);
prewitt = edge(STARBUCK(:,:,1), 'Prewitt', threshold, direction, thinning);
subplot(1,2,1), imshow(STARBUCK), title("Original image");
subplot(1,2,2), imshow(prewitt), title("Processed image");
% It is observed that the default edge detection of the Prewitt leads to
% several edge discontinuities, worst so than the default Sobel algorithm.
% The algorithm parameters will now be tuned to optimise performance. First
% the threshold will be decreased in the hope of reducing discontinuities.
threshold = threshold - 0.2;
prewitt = edge(STARBUCK(:,:,1), 'Prewitt', threshold, direction, thinning);
subplot(1,2,1), imshow(STARBUCK), title("Original image");
subplot(1,2,2), imshow(prewitt), title("Processed image");
% The processed image has less discontinuities. The line thinning is
% applied as before.
thinning = 'nothinning';
prewitt = edge(STARBUCK(:,:,1), 'Prewitt', threshold, direction, thinning);
subplot(1,2,1), imshow(STARBUCK), title("Original image");
subplot(1,2,2), imshow(prewitt), title("Processed image");
% The edge detection is optimised.

% 1. How many methods to obtain the edges of the image are implemented by the function edge?
% 6: Sobel, Prewitt, Laplacian of Gaussian, Roberts, Zerocross and Canny

% 2. Which is the best edge detector?
% Depends on the image.

% 3. What are the advantages and disadvantages when extracting edges on the
% different images? 

% Discuss if parameters should be changed for different images.

% "Gradient-based algorithms such as the Prewitt filter have a major drawback of being very sensitive to noise.
% The size of the kernel filter and coefficients are fixed and cannot be adapted to a given image. An adaptive
% edge-detection algorithm is necessary to provide a robust solution that is adaptable to the varying noise
% levels of these images to help distinguish valid image contents from visual artifacts introduced by noise.

% The performance of the Canny algorithm depends heavily on the adjustable parameters, ?, which is the
% standard deviation for the Gaussian filter, and the threshold values, ?T1? and ?T2?. ? also controls the size of the
% Gaussian filter. The bigger the value for ?, the larger the size of the Gaussian filter becomes. This implies more
% blurring, necessary for noisy images, as well as detecting larger edges. As expected, however, the larger the
% scale of the Gaussian, the less accurate is the localization of the edge. Smaller values of ? imply a smaller 
% Gaussian filter which limits the amount of blurring, maintaining finer edges in the image. The user can tailor the
% algorithm by adjusting these parameters to adapt to different environments.

% Canny?s edge detection algorithm is computationally more expensive compared to Sobel, Prewitt and Robert?s
% operator. However, the Canny?s edge detection algorithm performs better than all these operators under almost
% all scenarios. Evaluation of the images showed that under noisy conditions, Canny, LoG, Sobel, Prewitt,
% Roberts?s exhibit better performance, respectively."

% - International Journal of Image Processing (IJIP), Volume (3) : Issue (1) 10
%   Raman Maini & Dr. Himanshu Aggarwal
