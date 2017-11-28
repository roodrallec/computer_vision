%% Lab 9

% Reader
v = VideoReader('Barcelona.mp4');
num_frames = floor(v.Duration*v.FrameRate);

frame = 1;
prev_frame = readFrame(v);
prev_frame_hist = imagehist(prev_frame);

dist = zeros(num_frames-1,1) -1;
while hasFrame(v)
    curr_frame = readFrame(v);
    curr_frame_hist = imagehist(curr_frame);
    
    d = norm(curr_frame_hist-prev_frame_hist,2);
    dist(frame) = d;
    
    prev_frame = curr_frame; 
    prev_frame_hist = curr_frame_hist;
    frame = frame + 1;
end

%% Plot difference vector
plot(dist)



%%
function h = imagehist(frame)
    hist_R = imhist(frame(:,:,1));
    hist_G = imhist(frame(:,:,2));
    hist_B = imhist(frame(:,:,3));
    h = horzcat([hist_R hist_G hist_B]);  
end