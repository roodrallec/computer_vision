%Lab7Report.m

pool = parpool('local', 4);

animals_rgb = imread('images\animals.jpg');
imshow(runparallelanalysis(animals_rgb, 4, 60));


alwin2_rgb = imread('images\alwin2.jpg');
imshow(runparallelanalysis(alwin2_rgb, 4, 150));

bigbang_rgb = imread('images\bigbangfamily.png');
imshow(runparallelanalysis(bigbang_rgb, 4, 60));

pool.delete

%%
function [imres] = runmethod(im, k, b, usecoord, usemeancolour)
    % Function can perform the analysis of any combination of following
    % propertites:
    %  - Using k-means or MeanShiftCluster method
    %  - Using spatial coordinates or not
    %  - Using the mean colour of the cluster or not
    
    % Prepare Matrix of features
    im1d = reshape(im, size(im, 1) * size(im, 2), 3);
    
    if(usecoord)
        % Add spatial coordinates
        coord_y = repmat(1:size(im, 2), size(im, 1), 1);
        coord_y = coord_y(:);
        coord_x = repmat(1:size(im, 1), 1,size(im, 2))';
    
        im1d = [double(im1d), coord_x, coord_y];
    end
    
    % Method
    if(k > 0)
        idx = kmeans(double(im1d), k);
    elseif(b > 0)
        [~, ms_idx, ~] = MeanShiftCluster(double(im1d'), b, false);
        idx = ms_idx';
    end
    
    % Reshape cluster index into image dimensions
    im2d = reshape(idx, size(im, 1), size(im, 2));
    
    % Apply colour
    if(usemeancolour)    
        % Mean colour
        im2dres = zeros(size(im, 1), size(im, 2), 3);
        for cl = unique(idx)'
            idx_class = find(idx==cl);
            for ch = 1:3 % rgb
                idx_ch = idx_class + (ch-1) * (size(im,1) * size(im,2));
                im2dres(idx_ch) = mean(im(idx_ch)); 
            end
        end
        im2dres = uint8(im2dres);
    else
        % Black and white
        im2d = ((double(im2d) - min(min(im2d)))/ ...
            ((max(max(im2d)) - min(min(im2d)))+1e-16)* 255.0);  
        im2dres = cat(3, im2d, im2d, im2d);
    end
    
    imres = im2dres;
 
end

function [imres] = runanalysis(im, k, b)
    % k-means row
    km_nocoord_gray = runmethod(im, k, 0, false, false);
    km_nocoord_colo = runmethod(im, k, 0, false, true);
    km_xycoord_gray = runmethod(im, k, 0, true, false);
    km_xycoord_colo = runmethod(im, k, 0, true, true);
    
    km_row = horzcat(im, km_nocoord_gray, km_nocoord_colo, ...
        km_xycoord_gray, km_xycoord_colo);
    
    % MeanShift row
    ms_nocoord_gray = runmethod(im, 0, b, false, false);
    ms_nocoord_colo = runmethod(im, 0, b, false, true);
    ms_xycoord_gray = runmethod(im, 0, b, true, false);
    ms_xycoord_colo = runmethod(im, 0, b, true, true);
    
    ms_row = horzcat(im, ms_nocoord_gray, ms_nocoord_colo, ...
        ms_xycoord_gray, ms_xycoord_colo);
    
    imres = [km_row; ms_row];
    
end

function [imres] = runparallelanalysis(im, k, b)
    
    p = gcp('nocreate');

    % Generate matrix of parameters
    design_mat = combvec([0,1],[0,1],[0,1])';
    design_mat = [~design_mat(:,3)*k,design_mat(:,3)*b,design_mat(:,[2,1])];
    
    % Invoke runmethod executions
    for i = 1:size(design_mat,1)
        f(i) = parfeval(p, @runmethod, 1, im, design_mat(i,1), ...
            design_mat(i,2), design_mat(i,3), design_mat(i,4));
    end
    
    % Collect results as they become available
    results = cell(1,length(f));
    for i = 1:length(f)
      [completedIdx,value] = fetchNext(f);
      results{completedIdx} = value;
    end
  
    % Compose final image
    imres = [im, results{1:4}; im, results{5:8}]; 
    
end