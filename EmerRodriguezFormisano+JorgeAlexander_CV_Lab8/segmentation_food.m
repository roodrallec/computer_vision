%% Reading the image
col_img = imread('images/dishes/PB070009.JPG');
col_img = imresize(col_img, 0.25);
img = rgb2gray(uint8(col_img));
img = double(img);
%% Building phi initial contour
[nx,ny] = size(img);
[x,y] = meshgrid(1:nx,1:ny);
% Phi
f = sqrt( (x-70).^2 + (y-70).^2 ) - 5;
f = f';
f = f(1:nx, 1:ny);
g = ones(nx, ny);
% plotting initial level-set function
fig = figure(1);
s = surf(x,y,f'); axis equal; colorbar;
s.EdgeColor = 'none';
saveas(fig, 'levelset_food_f.jpg');
%% Displaying the initial position
fig = figure(2);
% Image with contour overlaid
subplot(1,1,1); imagesc(col_img); hold on; axis equal;
contour(f,[0,0],'r','LineWidth',2); hold off;
saveas(fig, 'segmentation_food_contour.jpg');
%% Performing the segmentation
% f=levelset(f,im,mu,nu,c1,c2,lambda1,lambda2,kappa,g,tau)
f1=levelset(f,img,50,0,100,200,0.5,0.5,0.05,g,1) ;
%% plotting the final result
fig = figure(3);
subplot(1,1,1); imagesc(col_img); hold on; axis equal;
contour(f1,[0,0],'r','LineWidth',2); hold off;
saveas(fig, 'segmentation_food.jpg');
