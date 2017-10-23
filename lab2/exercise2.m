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
frame = readFrame(vidObj);
imwrite(frame, 'frame_1.jpg');
% The first frame is analysed using the showedges function that was defined
showedges('frame_1.jpg');
% Sobel is seen to give good edge detection    
[sobel, thresh] = edge(rgb2gray(frame), 'Sobel', [], 'both', 'thinning');
sobel = edge(rgb2gray(frame), 'Sobel', thresh, 'both', 'thinning');    
highlightedFrame = overlapedges(frame, sobel);
imshow(highlightedFrame);

% % Here the video is edited and saved with highlighted edges 
reader = VideoReader('images_video/Maldives.mp4');
writer = VideoWriter('images_video/maldivesContour.mp4', 'MPEG-4');
writer.FrameRate = reader.FrameRate;
open(writer);
while hasFrame(reader)
    frame = readFrame(reader);
    [sobel, thresh] = edge(rgb2gray(frame), 'Sobel', [], 'both', 'thinning');
    sobel = edge(rgb2gray(frame), 'Sobel', thresh, 'both', 'thinning');    
    frame = overlapedges(frame, sobel);
    writeVideo(writer, frame);
end
close(writer);
