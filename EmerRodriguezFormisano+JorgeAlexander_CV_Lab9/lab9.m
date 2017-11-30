%% Lab 9
clear all;
v = VideoReader('./materialLab10/Barcelona.mp4');
num_frames = floor(v.Duration*v.FrameRate);
dist = zeros(num_frames - 1, 1);
idx = 1;
prev_hist = imagehist(readFrame(v));
while hasFrame(v)    
    curr_hist = imagehist(readFrame(v));
    dist(idx) = norm(curr_hist - prev_hist, 2);
    idx = idx + 1;
    prev_hist = curr_hist;
end

%% Plot difference vector
plot(dist)
%%
function h = imagehist(frame)    
    h = horzcat([imhist(frame(:,:,1)) imhist(frame(:,:,2)) imhist(frame(:,:,3))]);  
end