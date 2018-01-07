%% *UNIVERSITAT DE BARCELONA*
%% *COMPUTER VISION *
%% *LAB 11 REPORT*
% *JORGE ALEXANDER & EMER RODRIGUEZ FORMISANO*
% 
% VLFeat configuration:
%%
clear all;
VLFEAT_DIR = 'VLFEATROOT';
run(fullfile(VLFEAT_DIR,'/toolbox/vl_setup'));
vl_version;
%% 
% a) 
% 
% First, train the model with a subset of categories and load it:
%%
categorySubset = { 'Leopards', 'accordion', 'pizza', 'Faces', 'laptop', 'tick'};
modified_phow_caltech101(categorySubset);
modelPath = fullfile('data','baseline-model.mat');
load(modelPath);
%% 
% Add a function to train visualize the images in a green framework if the 
% classification is correct and in a red framework if it does not:
%%
% 
% Choose imageCount random images to classify and draw border around
% 
imageCount = 25;
imageBaseDir = fullfile('data','caltech-101','101_ObjectCategories');
imagePaths = buildImagePaths(imageBaseDir, categorySubset, imageCount);
visualizeImgClass(imagePaths, model);
%% 
% b) 
% 
% _What are the PHOW descriptors?  _
% 
% They represent the Pyramid Histogram Of visual Words. 
% 
% The function to obtain them is 
%%
%[FRAMES, DESCRS] = vl_phow(IMG)
%% 
% DESCRS, Each column of DESCRS is the descriptor of the corresponding frame 
% in FRAMES. A descriptor is a 128-dimensional vector of class UINT8.
% 
% It represents a 4x4 spatial histogram of gradient orientations, each with 
% 8 different directions, leading to a 4x4x8=128 dimensional vector.
% 
% FRAMES(1:2,:) are the x,y coordinates of the center of each descriptor, 
% FRAMES(3,:) is the contrast of the descriptor, as returned by VL_DSIFT() (for 
% colour variant, contranst is computed on the intensity channel). FRAMES(4,:) 
% is the size of the bin of the descriptor.
% 
% _What does the Sizes parameter mean? _
% 
% It's the scales at which the dense SIFT features are extracted. Each value 
% is used as the spatial bin size in pixels when extracting a dense set of SIFT 
% features from the image.
% 
% _What does happen if the Sizes parameter is augmented? _
% 
% From the lectures, the code to calculate the phow descriptors:

% step = 5;
% for size=[5,7,10,12]
%     [x,y]=meshgrid(1:step:width, 1:step:height);
%     frames = [x(:)'; y(:)'];
%     frames(3,:) = size/3;
%     frames(4,:) = 0;
%     [frames, descrs] = vl_sift(im, 'Frames', frames);
% end
%% 
% It can be observed that if the size is increased the size of the bin of 
% the descriptor is increased.				
% 
% _What does the Step parameter mean?_ 
% 
% Step (in pixels) of the grid at which the dense SIFT features are extracted.
% 
% _What does happen if the Step parameter is augmented?_
% 
% If the step parameter is augmented, then a grid with a lower resolution 
% is created, and less features are extracted.
% 
% c) 
% 
% _What are the words in the algorithm?_ 
% 
% _How are they extracted?_ 
% 
% _What is their dimension?_ 
% 
% _How their number does affect the accuracy of the results? _
%%
vocabPath = fullfile('data','baseline-vocab.mat'); load(vocabPath); vocab
%% 
% We observe that the vocab consists of 128x600. The 128 represents the 
% 128 dimensions of the sift descriptors generated by _vl_phow_, as explained 
% before. The 600 columns represent one word each. To extract the vocab, k-means 
% is applied to the sift descriptors. Each word of the vocab represents the centre 
% of the k-means clusters found. Observe the classification of 16 Pizzas images 
% below:

imageCount = 16; 
imagePaths = buildImagePaths(imageBaseDir, {'pizza'}, imageCount); 
visualizeImgClass(imagePaths, model);
%% 
% Now we attempt to classify the same pizzas with a reduced number of words.
%%
words = length(categorySubset);
modified_phow_caltech101(categorySubset, 'reduced-vocab', words);
%% 
% A lower accuracy of 84.44% is observed.

modelPath = fullfile('data','reduced-vocab-model.mat'); load(modelPath); model;
vocabPath = fullfile('data','reduced-vocab-vocab.mat'); load(vocabPath); vocab
visualizeImgClass(imagePaths, model);
%% 
% We observe that although the classification accuracy has gone down, in 
% the sample studied, the majority of pizzas have been classified correctly. There 
% are enough clusters to classify the categories quite well as they are equal 
% in size. We now try with less words than categories. 
%%
words = 2; modified_phow_caltech101(categorySubset, 'reduced-vocab', words);
%% 
% We now observe a much lower classification accuracy (51.1%), as there 
% are not enough words to classify each image to the different categories. Let's 
% see whether the same images are classified.

modelPath = fullfile('data','reduced-vocab-model.mat');
load(modelPath);
visualizeImgClass(imagePaths, model);
%% 
% It is now observed that many of the same pizzas are now classified incorrectly. 
% It important to have at least as many words as there are classification categories.
% 
% d) 
% 
% Explore and explain how the k-means is applied, which parameters are used, 
% what is there meaning and what are the advantages and the limitations of the 
% method.
% 
% Code to construct vocabulary:
%%
% vocab = vl_kmeans(descrs, conf.numWords, 'algorithm', 'elkan', 'MaxNumIterations', 50);
%% 
% The image descriptors are passed to the kmeans algorithm as the data to 
% cluster, and the number of words passed as an argument is used to determine 
% the number of centroids that the kmeans algorithm will cluster the data to.
% 
% The algorithm chosen in the example is the 'elkan' algorithm, which is 
% a fast version of the 'lloyd' algorithm, using triangular inequalities to optimize 
% it. The 'lloyd' algorithm finds evenly spaced sets of points, which is what 
% the k-means algorithm needs to find the centroid positions.
% 
% It finds a centroid for a set of points, and then re-partitions and re-calculates 
% the centroids. The 'MaxNumIterations' parameter limits how many times it re-calculates 
% in the case of it not converging before hand. Convergence is determined when 
% the centroids are re-calculated but have not changed position since the last 
% calculation. 
% 
% The advantages of k-means is that it is unsupervised, and therefore the 
% labels of the data do not need to be known. Also the clusters produced by k-means 
% can be reused on new data. So providing that the k-means algorithm has been 
% clustered on a large amount of image categories and corresponding images, it 
% can be used to cluster new data effectively.
% 
% However, selecting the ideal cluster size can sometimes be difficult, and 
% once a cluster size has been determined, the whole algorithm has to be re-run 
% to calculate a new cluster size.
% 
% 
% 
% 			
% 
% 		
% 
% 	 		
% 
% 
% 
% 	 
% 
% 
% 
% 
% 
%