%Lab7Report.m

% Read image
animals_rgb = imread('Archive\images\animals.jpg');
% figure()
% imshow(testkMeans(animals_rgb, 4, true, true, true))
% figure()
% imshow(testkMeans(animals_rgb, 4, false, true, true))
% figure()
% imshow(testkMeans(animals_rgb, 8, true, true, true))
figure()
imshow(testkMeans(animals_rgb, 10, true, true, true))

figure()
imshow(testkMeans(animals_rgb, 10, false, true, true))


%%
function [imres] = testkMeans(im, k, usecoord, usemeancolour, useoriginal)
    im1d = reshape(im, size(im, 1) * size(im, 2), 3);
    
    if(usecoord)
        % Add spatial coordinates
        coord_y = repmat(1:size(im, 2), size(im, 1), 1);
        coord_y = coord_y(:);
        coord_x = repmat(1:size(im, 1), 1,size(im, 2))';
    
        im1d = [double(im1d), coord_x, coord_y];
    end
    
    %k = 4; % Clusters
    idx = kmeans(double(im1d), k);
    im2d = reshape(idx, size(im, 1), size(im, 2));
    
    if(usemeancolour)    
        % Mean colour
        im2dres = zeros(size(im, 1), size(im, 2), 3);
        for cl = 1:k
            idx_class = find(idx==cl);
            for ch = 1:3 % rgb
                idx_ch = idx_class + (ch-1) * (size(im,1) * size(im,2));
                im2dres(idx_ch) = mean(im(idx_ch)); 
            end
        end
        im2dres = uint8(im2dres);
    else
        % Black and white
        im2d = ((double(im2d) - min(min(im2d)))/(max(max(im2d)) - min(min(im2d)))* 255.0);  
        im2dres = cat(3, im2d, im2d, im2d);
    end
    
    if(useoriginal)
        imres = cat(2, im, im2dres);
    else
        imres = im2dres
    end  
 
    
end