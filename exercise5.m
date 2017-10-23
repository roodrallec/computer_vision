% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jorge Alexander and Emer Rodriguez Formisano
% - - - - - - 


%%
%- - - - - - 
%Exercise 5: Image binarization
%- - - - - - -
% load image
CAR = imread('images/car_gray.jpg');
% PART 1
% binary with threshold 20
bin20 = thresholdImg(CAR, 20);
% threshold of 30, 150, 255
bin30 = thresholdImg(CAR, 30);
bin150 = thresholdImg(CAR, 150);
bin255 = thresholdImg(CAR, 255);
% plot the different images
subplot(1,5,1), imshow(CAR), title("Original");
subplot(1,5,2), imshow(bin20*255), title("20");
subplot(1,5,3), imshow(bin30*255), title("30");
subplot(1,5,4), imshow(bin150*255), title("150");
subplot(1,5,5), imshow(bin255*255), title("255");
% We observe that for a low threshold the image is very bright and hard
% to see detail. This is because a high portion of the image is being
% converted to ones.
% We observe that for a medium threshold there is a good contrast to see
% the edges of the car and detail. This is because there is a balanced
% proportion of elements being binarized to zero with those being binarized
% to 1.
% We observe that for a high threshold the image is very dark and it is
% hard to see detail of the image. This is because a large portion of the
% inormation of the image is being binarized to 0.
%     
% PART 2 - visualize and save threshold 150 image
subplot(1,1,1), imshow(bin150*255), title("150");
imwrite(bin150*255, 'car_binary.jpg');
% Part 3 - what happens when you multiply the original with the binary
% image?
subplot(1,3,1), imshow(CAR), title("Original");
subplot(1,3,2), imshow(bin150*255), title("Binary 150");
subplot(1,3,3), imshow(CAR .* bin150), title("Original * Binary 150");
% The resulting image contains the original intensity in the areas where the 
% binary image has the value of 1 while it is black in the areas of with value 
% 0.
% Part 4 - what happens if you multiply the original image with the
% inverted binary image?
% We consider the inverted image as the negative image. 
subplot(1,3,1), imshow(CAR), title("Original");
subplot(1,3,2), imshow(not(bin150)), title("Inv. Binary 150");
subplot(1,3,3), imshow(CAR .* uint8(not(bin150))), title("Original * Inv. Binary 150");

% Inverting the binary image makes the resulting image to be black where it
% was previously white. What was previously black, now it has the intensity
% from the original image. It is the same effect of the previous question
% but inverted.
