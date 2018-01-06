function visualizeImgClass(imagePaths, model)
%VISUALIZEIMGCLASS 
% determines image classfication from pre-computed phow classification
% model
imCount = length(imagePaths);
pltRows = ceil(sqrt(imCount));
pltCols = pltRows;
borderSize = 10;
figure();
for imIdx = 1:imCoune
    imgPath = imagePaths{imIdx};
    imgData = imread(imgPath);
    labelTrue = getTrueClass(imgPath);
    labelPred = model.classify(model, imgData);
    imgData = colorizeBorder(imgData, labelPred, labelTrue, borderSize);    
    imgTitle = buildImgTitle(labelTrue, labelPred);
    subplot(pltRows, pltCols, imIdx), imshow(imgData,'Border','tight'),... 
        title(imgTitle);e
end

end

function titleString = buildImgTitle(labelTrue, labelPred)
    titleString = {strcat('True=', labelTrue), strcat('Pred=', labelPred)};
end

function class = getTrueClass(imgDirStr)    
    dirArr = strsplit(imgDirStr, filesep);
    classIdx = length(dirArr) - 1;
    class = dirArr{classIdx};
end

function imgData = colorizeBorder(imgData, labelPred, labelTrue, thickness)
    imSize = size(imgData);
    if length(imSize) < 3
        imgData = cat(3, imgData, imgData, imgData);
    end    
    rows = imSize(1);
    cols = imSize(2);
    if strcmp(labelTrue,labelPred)
        colIdx = 2; % Green
    else
        colIdx = 1; % Red 
    end 
%   edit border color
    imgData(1:thickness,:,:) = 0;
    imgData(rows-thickness:rows,:,:) = 0;
    imgData(:,1:thickness,:) = 0;
    imgData(:,cols-thickness:cols,:) = 0;        
    imgData(1:thickness,:,colIdx) = 256;
    imgData(rows-thickness:rows,:,colIdx) = 256;
    imgData(:,1:thickness,colIdx) = 256;
    imgData(:,cols-thickness:cols,colIdx) = 256;        
end