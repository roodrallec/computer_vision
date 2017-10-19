% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Jorge Alexander
% - - - - - - 


%%
%- - - - - - 
%Exercise 5: Image binarization
%- - - - - - -

function thresholdImg()    
% load image
    CAR = imread('images/car_gray.jpg');
% binary with threshold 20
    bw = CAR >= 20;
% threshold of 30, 150, 255
    lowBw = CAR >= 30;
    mediumBw = CAR >= 150;
    highBw = CAR >= 255;

    subplot(1,3,1); imshow(lowBw);
    subplot(1,3,2); imshow(mediumBw);
    subplot(1,3,3); imshow(highBw);
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
% Part 2
    imshow(mediumBw);
    imwrite(mediumBw, 'car_binary.jpg');
% Part 3
    imshow(double(CAR)*double(mediumBw).');
%     Very distorted image
% Part 4
    imshow(double(CAR)*(double(mediumBw).^(-1)).');
%     Very distorted image
end

