function overlapedImage = overlapedges(rgbImage, edges)
    redCh = rgbImage(:,:,1);
    greenCh = rgbImage(:,:,2);
    blueCh = rgbImage(:,:,3);
    redCh(edges) = 255;
    greenCh(edges) = 0;
    blueCh(edges) = 0;
    overlapedImage = cat(3, redCh, greenCh, blueCh);      
end

