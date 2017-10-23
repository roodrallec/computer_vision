% - - - - - - 
% MAI CV
% Exercises Lab 2
% Author name: Jorge Alexander
% - - - - - - 


%%
%- - - - - - 
%Exercise 2: Enhancing images with edges
%- - - - - - 
% First the video object is loaded with the video file
vidObj = VideoReader('images_video/Maldives.mp4');
% Next the first frame is read and saved
firstFrame = readFrame(vidObj);
imwrite(firstFrame, 'frame_1.jpg');
% The first frame is analysed using the showedges function that was defined
showedges('frame_1.jpg');

