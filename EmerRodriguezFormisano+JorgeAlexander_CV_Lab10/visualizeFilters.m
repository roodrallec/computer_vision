function [ ] = visualizeFilters(F)
    figure();
    for k=1:size(F,3)        
        subplot(8,6,k); 
        imagesc(F(:,:,k)); colorbar; hold off; axis off;        
        title(strcat('F', num2str(k)));
    end
end