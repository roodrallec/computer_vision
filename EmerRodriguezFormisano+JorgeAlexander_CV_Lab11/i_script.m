%% i)

clear all;
VLFEAT_DIR = 'VLFEATROOT';
run(fullfile(VLFEAT_DIR,'/toolbox/vl_setup'));
vl_version;

%% 
TinyCat = {'BACKGROUND_Google', 'Faces', 'Faces_easy', 'Leopards', 'Motorbikes'};
% sizes = [5, 7, 10, 12];
% steps = [5, 7, 10, 12];

sizes = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
steps = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

[X,Y] = meshgrid(steps, sizes);
Z = zeros(size(X));
for i = 1:length(sizes)
    for j = 1:length(steps)
        opt = {'Verbose', 2, 'Sizes', sizes(i), 'Step', steps(j)};
        modified_phow_caltech101(TinyCat, 'f1-tests', 30, opt);
        load(fullfile('data','f1-tests-result.mat'));
        [F1, Precision, Recall] = f1Score(confus);
        Z(i,j) = mean(F1);
    end
end
%% i) Plot
surf(X,Y,Z)
hold on
imagesc(Z)
colorbar
set(gca, 'ytick', 1:length(sizes), 'yticklabel', sizes); ylabel("Sizes");
set(gca, 'xtick', 1:length(steps), 'xticklabel', steps); xlabel("Steps");
zlabel("Mean F1 Score");
title("PHOW Size and Step param. vs F1 score (5 cat.)");
