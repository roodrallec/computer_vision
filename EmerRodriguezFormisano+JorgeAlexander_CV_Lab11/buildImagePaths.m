function imagePaths = buildImagePaths(imageBaseDir,categorySubset)
imageNames = dir(fullfile(imageBaseDir, categorySubset{1}, '*.jpg'));
for dirIdx=2:length(categorySubset)
    imageNames = vertcat(imageNames,...
        dir(fullfile(strcat(imageBaseDir, categorySubset{dirIdx}), '*.jpg')));
end
imagePaths = {};
for idx=1:9
    randIdx = randsample(length(imageNames),1);
    randImg = imageNames(randIdx);
    path = fullfile(randImg.folder, randImg.name);
    imagePaths{idx} = path;
end
end

