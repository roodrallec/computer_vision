% SNAKE function analysis
img = imread('images/heart.pgm');
t = [0:0.5:2*pi]';
x = 70 + 3*cos(t);
y = 90 + 3*sin(t);
% To show the initial position, you can use the following code:
figure(1); imagesc(img);  colormap(gray);  axis image;  axis off;  hold on;
% Plot the initial circle
plot([x;x(1,1)], [y;y(1,1)], 'r', 'LineWidth', 2); hold off;
exportfig(gcf,'output_images/snake_input1.eps');

% Smoothed version of the image, normalized for convenience 
h = fspecial( 'gaussian', 20, 3 );
f = imfilter( double(img), h, 'symmetric' );
f = f-min(f(:));  f = f/max(f(:));

% Second figure
figure(2) ; imagesc(f) ; colormap(jet) ; colorbar ; axis image ; axis off ; 

% The external force is a negative gradient of the energy. 
% We start the snake evolution with alpha=0.1, beta=0.01,
% kappa=0.2, lambda=0.05.
% Note that the normalization constant is incorporated into kappa.

% The final position of the snake is shown 
% We can see that the boundary is well
% recovered. It is instructive to run the snake evolution for different
% values of the parameters and note how the evolution speed and the final
% shape changes. Start with small changes first; big changes make the
% snake behave in unpredictable ways.

[px,py] = gradient(-f);
kappa=1/max(abs( [px(:); py(:)]));
% snake(x,y,alpha,beta,kappa, lambda, fx,fy,maxstep, displ,img)
[x,y]=snake(x,y,0.1,0.01,0.2*kappa,0.05,px,py,0.4,1,img);

figure(3); imagesc(img); colormap(gray); 
hold on; axis image; axis off;

plot([x;x(1)],[y;y(1)],'r','LineWidth',2); hold off;