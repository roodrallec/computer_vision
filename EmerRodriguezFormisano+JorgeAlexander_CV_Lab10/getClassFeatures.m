function [features, images] = getClassFeatures(dirName,ext, color)
    if ~exist('color','var')         
        color=false;
    end
    files = dir(fullfile(dirName, ['*.', ext]));
    features = [];
    images = {};
    for f=1:length(files)
        img = imread(fullfile(files(f).folder, files(f).name));        
        imgFeatures = getFeatures(img);
        if (color == true)
            imgFeatures = horzcat(imgFeatures, getColorFeatures(img));
        end
        features(f,:) = imgFeatures;
        images{f} = img;
    end
end

