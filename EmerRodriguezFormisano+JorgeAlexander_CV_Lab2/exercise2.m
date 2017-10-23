% - - - - - - 
% MAI CV
% Exercises Lab 2
% Author name: Jorge Alexander
% - - - - - - 


%%
%- - - - - - 
%Exercise 2: Enhancing images with edges
%- - - - - - 
%% First the video object is loaded with the video file
vidObj = VideoReader('images_video/Maldives.mp4');
% Next the first frame is read and saved
frame = readFrame(vidObj);
imwrite(frame, 'frame_1.jpg');
% The first frame is analysed using the showedges function that was defined
showedges('frame_1.jpg');
% Canny is seen to give good edge detection    
sigma = 2;
[canny, thresh] = edge(rgb2gray(frame), 'Canny', [], sigma);
canny = edge(rgb2gray(frame), 'Canny', thresh);
highlightedFrame = overlapedges(frame, canny);
imshow(highlightedFrame);
% Here the video is edited and saved with highlighted edges using Canny
% edge detection with sigma=2 and thresh=[0.1250, 0.1625]
reader = VideoReader('images_video/Maldives.mp4');
writer = VideoWriter('images_video/maldivesContour.mp4', 'MPEG-4');
writer.FrameRate = reader.FrameRate;
open(writer);
sigma = 2;
thresh = [0.1250, 0.1625];
while hasFrame(reader)
    frame = readFrame(reader);
    canny = edge(rgb2gray(frame), 'Canny', thresh, sigma);
    frame = overlapedges(frame, canny);
    writeVideo(writer, frame);
end
close(writer);
% If we open the edited video, the edges of objects are observed more
% clearly. This is particularly useful for identifying and generating
% actions from the objects in the image, for example, car detection.