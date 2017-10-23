% - - - - - - 
% MAI CV
% Exercises Lab 2
% Author name: Jorge Alexander 
% - - - - - - 

%%
%- - - - - - 
%% Exercise 1: Determine the optimal edges
%- - - - - - 
% Read the image "starbuck.jpg" and find its edges using matlab function
% edge.
% Apply different operators (Sobel and Prewitt, Laplacian of Gaussian) and
% find the optimal parameters for each of them.
% Apply Canny edge detector (also implemented in the function edge).
% Overlap the edges on the image as shown in Fig.2 (right).
% Overlap the edges as in Fig.2
% Repeat the experiment on 3 other images.
for filename = {'./images_video/starbuck.jpg', './images_video/doulphin.jpg', './images_video/Einstein.jpg'}
    showedges(filename{1});
end