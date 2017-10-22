% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jorge Alexander
% - - - - - - 


%%
%- - - - - - 
%Exercise 6:
%- - - - - - 
% 1
HAND = imread('images/hand.jpg');
MAPFRE = imread('images/mapfre.jpg');
grayscaleHand = rgb2gray(HAND);
% 2
foregroundHand = grayscaleHand >= 50;
backgroundHand = grayscaleHand < 50;
reverseBinary = (foregroundHand - 1).^2;
% note reverse binary == backgroundHand
subplot(1,4,1), imshow(HAND);
subplot(1,4,2), imshow(foregroundHand);
subplot(1,4,3), imshow(backgroundHand);
subplot(1,4,4), imshow(reverseBinary);

% 3
background = MAPFRE.*uint8(reverseBinary);
foreground = HAND.*uint8(foregroundHand);
handMapfre = background + foreground;
subplot(1,1,1), imshow(handMapfre);

% 4 
imwrite(handMapfre, 'hand_mapfre.jpg');

