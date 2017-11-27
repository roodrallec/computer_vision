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
%% Function to reset the parameters
load birdxy
[fx,fy] = gradient(-img);
alpha = 0.1;
beta = 0.01;
kappa=1/max(abs([fx(:); fy(:)]));
lambda = -0.05;
maxstep = 0.4;
kappa = -6;
%% Active contour with parameters
fig = figure(1);
[x,y]=snake(x,y,alpha,beta,kappa,lambda,fx,fy,maxstep,0,img);
subplot(1,1,1); imagesc(img); colormap(gray); hold on; title('S&P Optimal Kappa');
plot([x;x(1)],[y;y(1)],'r','LineWidth',2); hold off;
saveas(fig, 'segmentation_bird_salt_pepper_optimal.bmp');
