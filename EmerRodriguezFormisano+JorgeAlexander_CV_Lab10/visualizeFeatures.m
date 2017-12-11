function [  ] = visualizeFeatures(textDescArr, format, features)
    figure();    
    for d=1:length(textDescArr)
        textDesc=textDescArr{d};        
        
        for x=1:size(textDesc, 1)
            imageFeatures = textDesc(x, features);
            plot(x, imageFeatures, format{d}, 'MarkerSize', 5); hold on;
        end
    end
    hold off;
    xlabel('Image idx');
    ylabel('Mean value of filter convolution');
end