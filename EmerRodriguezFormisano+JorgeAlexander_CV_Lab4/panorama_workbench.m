panorama('images/im2_ex1.jpg','images/im1_ex1.jpg', 4, 100)

function panorama(filenameA, filenameB, thres, max_iter)
    % Load images
    Ia_rgb = imread(filenameA);
    Ib_rgb = imread(filenameB);
    Ia = single(rgb2gray(Ia_rgb));
    Ib = single(rgb2gray(Ib_rgb));
    
    % Calculate SIFT features and descriptors
    [fa, da] = vl_sift(Ia);
    [fb, db] = vl_sift(Ib);
    [matches, scores] = vl_ubcmatch(da, db, thres);
    numMatches = size(matches, 2);
    xa = fa(1:2, matches(1, :));
    xb = fb(1:2, matches(2, :));
    
    % RANSAC 
    sample_size = 10;
    prev_p = 0;
    prev_n = 0;
    for m = 1:max_iter
        % 2.a
        subset = vl_colsubset(1:numMatches, sample_size);
        % 2.b
        d = xb(1:2, subset) - xa(1:2, subset);
        p = mean(d, 2);
        % 2.c
        xb_ = zeros(size(xb));
        for i = 1:numMatches
            xb_(:,i) = xa(:,i) + p;
        end
        % 2.d (it can be combined with the previous loop)
        n = 0;
        for i = 1:numMatches
            e = xb_(:, i) - xb(:, i);
            if (norm(e) < 5)
                n = n + 1;
            end
        end
        % 2.e
        % Select the mean displacement with largest number of points near
        % to the original ones.
        if (n > prev_n)
            prev_n = n;
            prev_p = p;
%             disp(prev_n)
        end  
    end
    p = prev_p;
    % 3.b
    box2 = [1 size(Ia, 2) size(Ia, 2) 1;
            1 1           size(Ia, 1) size(Ia, 1)];
    box2_ = zeros(2,4);
    for i=1:4
        box2_(:,i) = box2(:,i) + p;
    end
    min_x = min(1, min(box2_(1, :)));
    min_y = min(1, min(box2_(2, :)));
    max_x = max(size(Ib, 2), max(box2_(1, :)));
    max_y = max(size(Ib, 1), max(box2_(2, :)));
    
    ur = min_x:max_x;
    vr = min_y:max_y;
    [u, v] = meshgrid(ur, vr);
    Ib_ = vl_imwbackward(im2double(Ib), u, v);
    
    p_inverse = -p;
    u_ = u + p_inverse(1);
    v_ = v + p_inverse(2);
    Ia_ = vl_imwbackward(im2double(Ia), u_, v_);
    
    Ib_(isnan(Ib_)) = 0;
    Ia_(isnan(Ia_)) = 0;
    
    panoramic = max(Ib_, Ia_);
    imshow(panoramic,[]);
    
end 