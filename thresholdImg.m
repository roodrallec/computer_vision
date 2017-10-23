function binImg = thresholdImg(img, thresh)
%THRESHOLDIMG Convert Gray Image into Binary Image
%    Transform the image (img) into a binary image (of 0s and 1s) that will depend on 
%    whether the level of the pixel intensity of the original image is above or below 
%    a threshold (tresh). The result type is uint8 for better compatibility with gray images.
    binImg = uint8(img >= thresh);
end

