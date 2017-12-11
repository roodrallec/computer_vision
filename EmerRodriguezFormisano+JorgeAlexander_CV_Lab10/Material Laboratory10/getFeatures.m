function desc = getFeatures(img)    
    I=rgb2gray(uint8(img));
    filters=makeLMfilters();
    filterSize=size(filters,3);
    desc = zeros(1,filterSize);
    for f=1:filterSize
        conv = conv2(double(I), double(filters(:,:,f)),'same');
        desc(f) = mean(mean(conv));
    end
end