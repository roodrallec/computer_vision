function [ ] = visualizeFeatures3D(textDescArr, format, features)
    figure();
    
    for d=1:length(textDescArr)
        textDesc=textDescArr{d};
        x = textDesc(:, features(1));
        y = textDesc(:, features(2));            
        z = textDesc(:, features(3));            
        plot3(x, y, z, format{d}, 'MarkerSize', 5); hold on;        
    end
    xlabel('Feature 1 convolution values');
    ylabel('Feature 2 convolution values');
    zlabel('Feature 3 convolution values');
end

