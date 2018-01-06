function imagePaths = buildImagePaths(imageBaseDir,categorySubset, imageCount)
imageNames = dir(fullfile(imageBaseDir, categorySubset{1}, '*.jpg'));
for dirIdx=2:length(categorySubset)
    directory = dir(fullfile(imageBaseDir, categorySubset{dirIdx}, '*.jpg'));
    imageNames = vertcat(imageNames, directory);
end
imagePaths = {};
for idx=1:imageCount
    randIdx = randsample(length(imageNames),1);
    randImg = imageNames(randIdx);
    path = fullfile(randImg.folder, randImg.name);
    imagePaths{idx} = path;
end
end

