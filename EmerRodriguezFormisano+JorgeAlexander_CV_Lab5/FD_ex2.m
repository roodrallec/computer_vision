% - - - - - - 
% MAI CV
% Exercises Lab 5
% Author name: Emer Rodriguez Formisano and Jorge Alexander
% - - - - - - 
% >> OBJECTIVE:
% 1) Write the code for Exercise 3
% 2) Execute the code and check the results
% 3) Comment the experiments and results in a report

% main
function FD_ex2()
clc; close all; clear;

%% Initialization
% Initialize the vector for storing the detection rate for each frame
detection_rate = [];

%% Detection over a video sequence (100 frames)

% Create a cascade detector object.
faceDetector = vision.CascadeObjectDetector();
videoFileReader = vision.VideoFileReader('Black_or_White_face_Morphing.mp4');

face_frames = {};
nonface_frames = {};
frame = 1;
while ~isDone(videoFileReader) && frame <= 100

    % Extract the next video frame
    [I, AUDIO] = step(videoFileReader);  
    
    % Select a video frame and run the detector.
    bboxes = step(faceDetector, I);
    
    % Draw the returned bounding box around the detected face.
    if(isempty(bboxes))
        nonface_frames = [nonface_frames {I}];
    else
        I = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
        face_frames = [face_frames {I}];
    end
    %imshow(I), title('Frame: ' + string(frame));
    frame = frame + 1;
    
end
% Frames detected as faces, with some false positives
imshow([face_frames{2:3};face_frames{10:11};[face_frames{83} face_frames{89}]]);
% Frames detected as non faces
imshow([nonface_frames{2:3};nonface_frames{4:5};nonface_frames{7:8}]);


end















