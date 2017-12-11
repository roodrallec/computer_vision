function colorFeatures = getColorFeatures(img)
    r = mean(mean(img(:,:,1)));
    g = mean(mean(img(:,:,2)));
    b = mean(mean(img(:,:,3)));
    colorFeatures = [r,g,b];
end