%% Active contour segmentation of heart image
clear all;
%% Initial image
img = imread('images/heart.pgm');
%% Smooth the image
img = imfilter(double(img), fspecial('gaussian', 20, 3), 'symmetric');
img = img-min(img(:));
img = img/max(img(:));
%% Tweak parameters
alphaTweak = 1;
betaTweak = 5;
kappaTweak = 1;
lambdaTweak = 1;
maxstepTweak = 0.5;
%% Segmentation function
fig = segmentation(img, alphaTweak, betaTweak, kappaTweak, lambdaTweak, maxstepTweak, @loadInitialValues);
saveas(fig, 'segmentation_heart.bmp');
%% Function to reset the parameters for the heart
function [x,y,alpha,beta,kappa,lambda,fx,fy,maxstep] = loadInitialValues(img)
    t = [0:0.5:2*pi]';
    x = 70 + 3*cos(t);
    y = 90 + 3*sin(t);
    [fx,fy] = gradient(-img);
    alpha = 0.1;
    beta = 0.01;
    kappa=1/max(abs([fx(:); fy(:)]));
    lambda = 0.05;
    maxstep = 0.4;
    kappa = 0.2*kappa;
end
