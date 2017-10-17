% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Emer Rodriguez Formisano
% - - - - - - 


%%
%- - - - - - 
%Exercise 1:
%- - - - - - 

% 1.1
img1 = zeros([200, 200]);
img1(1:200,100:200) = 1;
imshow(img1)

img2 = zeros([200, 200]);
img2(100:200,1:200) = 1;
imshow(img2)

img3 = zeros([200, 200]);
img3(1:100,1:100) = 1;
imshow(img3)

img3 = zeros([200, 200]);
img3(1:100,1:100) = 1;
imshow(img3)

% 1.2
img4 = cat(3, img1, img2, img3);
imshow(img4)

% 1.3
imwrite(img4, '3channels.jpg')
