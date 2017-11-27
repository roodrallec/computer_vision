%% Active contour segmentation of bird image
clear all;
%% Initial image
img = imread('images/dishes/PB070009.JPG');
col_img = imresize(img, 0.25);
img = rgb2gray(uint8(img));
%% Apply filter to the image
f=double(img);
f=f-min(f(:)) ; f=f/max(f(:)) ;
f=(f>0.25).*f ;
h=fspecial('gaussian',20,3) ;
img=imfilter(double(f),h,'symmetric') ;
%% Configure the parameter tweaking
alphaTweak = 1;
betaTweak = 5;
kappaTweak = 1;
lambdaTweak = 1;
maxstepTweak = 1;
%% Perform the segmentation
fig = segmentation(img, alphaTweak, betaTweak, kappaTweak, lambdaTweak, maxstepTweak, @loadInitialValues);
saveas(fig, 'segmentation_snake_food.jpg');
%% Function to reset the parameters
function [x,y,alpha,beta,kappa,lambda,fx,fy,maxstep] = loadInitialValues(img)
    t = [0:0.5:2*pi]';
    x = 250 + 25*cos(t);
    y = 250 + 25*sin(t);
    [fx,fy] = gradient(-img);
    alpha = 0.1;
    beta = 0.01;
    kappa=1/max(abs([fx(:); fy(:)]));
    lambda = 0.05;
    maxstep = 0.4;
    kappa = 0.4*kappa;
end
