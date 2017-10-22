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
% % Original image
STARBUCK = imread('./images_video/starbuck.jpg');
imshow(STARBUCK)
% The traditional Starbucks logo, in color.
% As a measure of the quality of the edge detection, 
% the edges between the eyes of the mermaid in the image will be used.

% % Matlab edge function with default parameters
starbuckEdge = edge(STARBUCK(:,:,1));
subplot(1,2,1), imshow(STARBUCK), title("Original image");
subplot(1,2,2), imshow(starbuckEdge), title("Processed image");
% The edges between the eyes are correctly defined. However,
% discontinuities in the edges of some of the letters are observed, for
% example, the letter A. A tuning of parameters is now tried to optimise
% the edge etection.

%% Parameter tuning
% Apply different operators and find the optimal parameters for each of
% them

% "In all cases, edge chooses the default threshold heuristically, depending on the input data. 
% The best way to vary the threshold is to run edge once, capturing the calculated threshold as the second output argument. 
% Then, starting from the value calculated by edge, adjust the threshold
% higher (fewer edge pixels) or lower (more edge pixels)."
% - MathWorks edge function documentation

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


sigma = 2;    % Scalar value that specifies the standard deviation of the Laplacian of Gaussian filter. 
                % The default is 2. The size of the filter is n-by-n, where n=ceil(sigma*3)*2+1.
[log, threshold] = edge(STARBUCK(:,:,1), 'log', [], sigma);
[log, threshold] = edge(STARBUCK(:,:,1), 'log', threshold, sigma);
subplot(1,1,1), imshow(log), title('Laplacian of Gaussian');

roberts = edge(STARBUCK(:,:,1), 'Roberts');
zerocross = edge(STARBUCK(:,:,1), 'zerocross');
canny = edge(STARBUCK(:,:,1), 'Canny');

subplot(2,3,1), imshow(sobel), title('Sobel');
subplot(2,3,2), imshow(prewitt), title('Prewitt');
subplot(2,3,4), imshow(log), title('Laplacian of Gaussian');

subplot(2,3,3), imshow(roberts), title('Roberts');
subplot(2,3,5), imshow(zerocross), title('Zerocross');
subplot(2,3,6), imshow(canny), title('Canny');

% How many methods to obtain the edges of the image are implemented by the function edge?
% 6: Sobel, Prewitt, Laplacian of Gaussian, Roberts, Zerocross and Canny

% Which is the best edge detector?

% What are the advantages and disadvantages when extracting edges on the
% different images?

% Discuss if parameters should be changed for different images.
