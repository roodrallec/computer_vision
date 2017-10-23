% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Emer Rodriguez Formisano and Jorge Alexander
% - - - - - - 


%%
%- - - - - - 
%Exercise 6:
%- - - - - - 
% 1 Read Input
HAND = imread('images/hand.jpg');
MAPFRE = imread('images/mapfre.jpg');
grayscaleHand = rgb2gray(HAND);

% 2 Binarization
th = 20;
foregroundHand = grayscaleHand >= th;
backgroundHand = not(foregroundHand);

subplot(2,2,1), imshow(HAND), title("Original Hand");
subplot(2,2,2), imshow(MAPFRE), title("Original Mapfre");
subplot(2,2,3), imshow(foregroundHand), title("Foreground");
subplot(2,2,4), imshow(backgroundHand), title("Background");

% 3 Merge
background = MAPFRE.*uint8(backgroundHand);
foreground = HAND.*uint8(foregroundHand);
handMapfre = background + foreground;
subplot(1,1,1), imshow(handMapfre), title("Hand + Mafre");

% 4 Save output
imwrite(handMapfre, 'hand_mapfre.jpg');

