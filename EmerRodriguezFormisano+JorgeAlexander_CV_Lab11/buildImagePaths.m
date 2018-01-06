function imagePaths = buildImagePaths(imageBaseDir,categorySubset, imageCount)
imageNames = dir(fullfile(imageBaseDir, categorySubset{1}, '*.jpg'));
for dirIdx=2:length(categorySubset)
    directory = dir(fullfile(imageBaseDir, categorySubset{dirIdx}, '*.jpg'));
    imageNames = vertcat(imageNames, directory);
end
imagePaths = {};
randIdxs = randsample(length(imageNames), imageCount);
for idx=1:imageCount    
    randImg = imageNames(randIdxs(idx));
    path = fullfile(randImg.folder, randImg.name);
    imagePaths{idx} = path;
end
end

