%% Reading the image
col_img = imread('images/dishes/PB070009.JPG');
col_img = imresize(col_img, 0.25);
img = im2double(col_img);
img = rgb2gray(img);
%% Building phi initial contour
[nx,ny] = size(img);
[x,y] = meshgrid(1:nx,1:ny);
% Phi
f = sqrt( (x-70).^2 + (y-70).^2 ) - 5;
f = f';
f = f(1:nx, 1:ny);
g = ones(nx, ny);
%% Displaying the initial position
figure(1);
% Image with contour overlaid
subplot(2,1,1); imagesc(col_img); hold on; axis equal;
contour(f,[0,0],'r','LineWidth',2); hold off;
%% Performing the segmentation
% f=levelset(f,im,mu,nu,c1,c2,lambda1,lambda2,kappa,g,tau) ;
f1=levelset(f,img,100,10,3,10,0.5,0.5,0.07,g,1) ;
%% plotting the final result
subplot(2,1,2); imagesc(col_img); hold on; axis equal;
contour(f1,[0,0],'r','LineWidth',2); hold off;
