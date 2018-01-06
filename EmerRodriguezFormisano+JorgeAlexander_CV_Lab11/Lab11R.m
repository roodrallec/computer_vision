

% Note for Jorge, we need to use versio 0.9.20 as the code we have to study
% was modified from version 0.9.16 used in the previous assignment
%% Load VLFeat and run build phow models

% vl_version;
% run('phow_caltech101.m');
% % Add a function to visualize the images in a green framework if 
% the classification is correct and in a red framework if it does not 
modelPath = 'data/baseline-model.mat';
imageDir = {...
    'data/caltech-101/101_ObjectCategories/Leopards/',...
    'data/caltech-101/101_ObjectCategories/accordion/',...
    'data/caltech-101/101_ObjectCategories/pizza/',...
    'data/caltech-101/101_ObjectCategories/Faces/'    
};
imageNames = dir(fullfile(imageDir{1}, '*.jpg'));
for dirIdx=2:length(imageDir)
    imageNames = vertcat(imageNames, dir(fullfile(imageDir{dirIdx}, '*.jpg')));
end

% b) What are the PHOW descriptors? 
% PHOW Descriptors (Pyramid histogram of visual Words)


% What does the Sizes parameter mean? 
% What does happen if the Sizes parameter is augmented? What does the 
% Step parameter mean? What does happen if the Step parameter is augmented?



