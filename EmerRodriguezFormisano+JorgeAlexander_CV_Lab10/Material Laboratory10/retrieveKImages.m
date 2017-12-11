function images = retrieveKImages(imgIdx, imgDirectories, imgFormat, k, color)
    if ~exist('color','var')         
        color=false;
    end
    allFeatures = [];
    allImages = {};
    for d=1:length(imgDirectories)        
        directory = imgDirectories{d};
        [features, images] = getClassFeatures(directory, imgFormat, color);        
        allFeatures = vertcat(allFeatures, features);
        allImages = horzcat(allImages, images);
    end    
    
    imgFeatures = allFeatures(imgIdx,:);        
    [IDX,D]=knnsearch(allFeatures, imgFeatures, 'k', k+1, 'distance', 'euclidean');
    
    figure; name='Image Query'; plotSize=ceil((k+1)/2);
    subplot(2, plotSize, 1); imshow(allImages{imgIdx}); title(name);
    
    for i=2:length(IDX)
        name = strcat('Image similarity: ', num2str(D(i)));
        subplot(2, plotSize, i); imshow(allImages{IDX(i)}); title(name);
    end    
    images = allImages(IDX);
end

