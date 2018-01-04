

% Note for Jorge, we need to use versio 0.9.20 as the code we have to study
% was modified from version 0.9.16 used in the previous assignment
%% Load VLFeat
VLFEAT_DIR = '/Users/jnalexander/Projects/VLFEATROOT';
run(fullfile(VLFEAT_DIR,'/toolbox/vl_setup'));
vl_version;
% a) Download the Caltech101 database from Campus Virtual and store it in 
% a subdirectory named data. Run step by step and explore the BOW object 
% recognition algorithm given by phow_caltech101.m. Assure that you are 
% working with a subset of categories and that the model is trained and 
% tested. Add a function to visualize the images in a green framework if 
% the classification is correct and in a red framework if it does not 
% (see Fig.1).
run(fullfile(VLFEAT_DIR,'/apps/phow_caltech101.m'));
vl_version;
% b) What are the PHOW descriptors? 
% PHOW Descriptors (Pyramid histogram of visual Words)


% What does the Sizes parameter mean? 
% What does happen if the Sizes parameter is augmented? What does the 
% Step parameter mean? What does happen if the Step parameter is augmented?



