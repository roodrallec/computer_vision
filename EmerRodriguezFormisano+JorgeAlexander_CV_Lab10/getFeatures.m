function [desc, convImages] = getFeatures(img)    
    I=rgb2gray(uint8(img));
    filters=makeLMfilters();
    filterSize=size(filters,3);
    desc = zeros(1,filterSize);
    convImages = {};
    for f=1:filterSize
        conv = conv2(double(I), double(filters(:,:,f)),'same');
        convImages{f} = conv;
        desc(f) = mean(mean(conv));
    end
end