function mirror = mirror_image(image, cut_col) 
%MIRROR Take an image and return its mirror, reflected at the specified cut column
    width = length(image(1, :, 1));
    left = image(:,1:cut_col,:);
    right = image(:, cut_col:width, :);
    mirror = [right, left];
end

