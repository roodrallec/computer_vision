%% Active contour segmentation of bird image with salt & pepper noise
clear all;
%% Initial image
img = imread('images/bird.png');
%% Add noise to the image
img = imnoise(img, 'salt & pepper', 0.0001);
%% Apply filter to the image
f=double(img) ; f=f(:,:,1)*0.5+f(:,:,2)*0.5-f(:,:,3)*1 ;
f=f-min(f(:)) ; f=f/max(f(:)) ;
f=(f>0.25).*f ;
h=fspecial('gaussian',20,3) ;
img=imfilter(double(f),h,'symmetric') ;
%% Configure the parameter tweaking
alphaTweak = 1;
betaTweak = 5;
kappaTweak = 1;
lambdaTweak = 1;
maxstepTweak = 0.5;
%% Perform the segmentation
fig = segmentation(img, alphaTweak, betaTweak, kappaTweak, lambdaTweak, maxstepTweak, @loadInitialValues);
saveas(fig, 'segmentation_bird_salt_pepper.bmp');
%% Function to reset the parameters
function [x,y,alpha,beta,kappa,lambda,fx,fy,maxstep] = loadInitialValues(img)
    load birdxy
    [fx,fy] = gradient(-img);
    alpha = 0.1;
    beta = 0.01;
    kappa=1/max(abs([fx(:); fy(:)]));
    lambda = -0.05;
    maxstep = 0.4;
    kappa = 0.3*kappa;
end
