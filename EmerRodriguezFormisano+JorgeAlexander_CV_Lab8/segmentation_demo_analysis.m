%% Demo phi comparison
img = double( imread([ImageDir 'mribrain.png']) );
[ny,nx] = size(img);
[x,y]   = meshgrid( 1:nx, 1:ny );
f = sqrt((x-nx/2).^2+(y-ny/3).^2)-5;
fig = figure(1);
s = surf(x,y,f); axis equal; colorbar;
s.EdgeColor = 'none';
saveas(fig, 'levelset_demo_f.bmp');
