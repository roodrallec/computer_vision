%Lab7Report.m

% Read image
animals_rgb = imread('Archive\images\animals.jpg');
imshow(testkMeans(animals_rgb))

% 

%%
function [imres] = testkMeans(im)
    im1d = reshape(im, size(im, 1) * size(im, 2), 3);
    
    % Add spatial coordinates
    coord_y = repmat(1:size(im, 2), size(im, 1), 1);
    coord_y = coord_y(:);
    coord_x = repmat(1:size(im, 1), 1,size(im, 2))';
    
    im1d = [double(im1d), coord_x, coord_y];
    
    k = 4; % Clusters
    idx = kmeans(double(im1d), k);
    
    im2d = reshape(idx, size(im, 1), size(im, 2));
    im2d = ((double(im2d) - min(min(im2d)))/(max(max(im2d)) - min(min(im2d)))* 255.0);  
   
    
    imres = cat(2, im, cat(3, im2d, im2d, im2d));
    
    
    
    
 
    
end