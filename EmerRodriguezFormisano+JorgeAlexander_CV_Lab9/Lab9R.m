%% Lab 9
clear all; clc;
v = VideoReader('./Barcelona.mp4');


%%  Shots detection using distances and threshold
dist = getframedifferences(v);
cuts_start_frame = getscenestarttime(dist);

dist_ref = quantile(dist, 0.97648);
plot(dist), title("Frame RGB Histogram differences");
xlabel("Frame"), ylabel("Euclidean distance of consecutive frames");
hline = refline([0 dist_ref]);
hline.Color = 'r';
    
%% Apply the background substraction to each cut
samples = [];
for i = 1:length(cuts_start_frame)-1
    [video_frames, bg_frame, fg_video] = getscenematrix( ...
        v, cuts_start_frame(i), diff(cuts_start_frame(i:i+1))-1);    
    middle_idx = max([1, floor(size(video_frames,4)/2)]);
    
    % Report results
    %implay(video_frames)
    %implay(fg_video)
    frame = video_frames(:,:,:,middle_idx);
    fg_frame = fg_video(:,:,:,middle_idx);
    
    row_samples = [frame bg_frame fg_frame];
    imshow(row_samples)
    %w = waitforbuttonpress;
    if i < 9
        samples = [samples; row_samples];
    end
end
imshow(samples)
%% Optional
vwt = VideoReader('./windturbine.mov');
[vwt_frames, vwt_bg_frame, vwt_fg_video] = getscenematrix(vwt, 1, 381);
imshow([vwt_frames(:,:,:,190); vwt_bg_frame; vwt_fg_video(:,:,:,190)]);
implay(vwt_fg_video)

%% Functions
function dist = getframedifferences(v)
    % Function computes the histogram differences of consecutive frames
    num_frames = floor(v.Duration*v.FrameRate);
    dist = zeros(num_frames - 1, 1);
    idx = 1;
    prev_hist = imagehist(readFrame(v));

    while hasFrame(v)    
        frame = readFrame(v);
        curr_hist = imagehist(frame);
        dist(idx) = norm(curr_hist - prev_hist, 2);
        idx = idx + 1;
        prev_hist = curr_hist;
    end
end

function h = imagehist(frame)    
    h = horzcat([imhist(frame(:,:,1)) imhist(frame(:,:,2)) imhist(frame(:,:,3))]);  
end

function start_frame = getscenestarttime(dist)
    % Function finds the threshold and return the index of the starting
    % frame of the cut
    true_start = [104 196 289 367 728 909 1091 1272 1454 ...
        1636 1818 2090 2362 2582 2810 2991 3169 3355 3445 3539 ...
        3629 3716 3913 3991 4081 4173 4264 4447 4539 4719 4901 ...
        4993 5083 5265 5446 5537 5629 5809 5991 6175 6537 6718 ...
        6901 7083 7266 7447 7628 7720 7811 7992 8174 8264 8310 ...
        8355 8401 8577 8772 8955 9129]'; % End 9129 (Black)
    
    % Find a good threshold based on grown truth cuts.
    % Jaccard Coefficient used
    best_diff = 0;    
    for qthres = linspace(0.900, 0.999, 5000)
        thres = quantile(dist, qthres);
        prop_start = find(dist > thres) + 1;
        % Remove credits zone
        prop_start = prop_start(prop_start <= 8955);
        % Remove cuts < 1 second (FrameRate)
        prop_start = prop_start([true; diff(prop_start) > 25]);
        % err = norm(prop_start - true_start, 2);
        jaccoef = length(intersect(true_start, prop_start)) ...
            /length(union(true_start, prop_start));
        if jaccoef > best_diff
            best_diff = jaccoef;
            best_qthres = qthres;
            best_start = prop_start;
        end
    end
    
    disp("Best percentile: " + best_qthres + " with Jaccard: " + best_diff) 
    start_frame = [1; best_start];
    
end


function [video_frames, bg_frame, fg_video] = getscenematrix( ...
    v, start_frame, length_frame)
    % Function that returns the cut's matrix of frames together with
    % the background (median frame) and foreground video (matrix of frames)
    video_frames = zeros(v.Height, v.Width, 3, length_frame, 'uint8');
    if start_frame == 1
     start_ts = 0.0;
    else
     start_ts = start_frame/v.FrameRate;
    end
    v.CurrentTime = start_ts;
    for f = 1:length_frame
     video_frames(:,:,:,f) = readFrame(v);
    end
    % Compute Median frame (background)
    bg_frame = median(video_frames, 4);
    % Substract background (foreground video frames)
    fg_video = video_frames - bg_frame;

end




