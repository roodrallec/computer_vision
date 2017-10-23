function fuseImg()
%fuseImg Function that executes steps 1 to 4 of Exercise 6

% 1 Read Input
HAND = imread('images/hand.jpg');
MAPFRE = imread('images/mapfre.jpg');
grayscaleHand = rgb2gray(HAND);

% 2 Binarization
th = 20;
foregroundHand = grayscaleHand >= th;
backgroundHand = not(foregroundHand);

% 3 Merge
background = MAPFRE.*uint8(backgroundHand);
foreground = HAND.*uint8(foregroundHand);
handMapfre = background + foreground;

% 4 Save output
imwrite(handMapfre, 'hand_mapfre.jpg');

end

