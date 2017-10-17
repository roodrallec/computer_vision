% - - - - - - 
% MAI CV
% Exercises Lab 1
% Author name: Emer Rodriguez Formisano
% - - - - - - 


%%
%- - - - - - 
%Exercise 2:
%- - - - - - 

% 2.1
buffetRGB = imread('images\buffet.jpg');

% 2.2
subplot(1,4,1)
imshow(buffetRGB)
title('Color')
subplot(1,4,2)
imshow(buffetRGB(:,:,1))
title('Red Channel')
subplot(1,4,3)
imshow(buffetRGB(:,:,2))
title('Green Channel')
subplot(1,4,4)
imshow(buffetRGB(:,:,3))
title('Blue Channel')

% Green vase and cabinet are white in the Green channel because the values 
% closer to 255. 
% The yellow color (sofa) is composed by the mixture of Red and Green colors
% The sofa is dark in the blue channel because it has no blue component.
% The wall (black and white background) does not change across channels
% which means the values are constant.

% 2.3
buffet_interchannel = buffetRGB;
buffet_interchannel(:,:,1) = buffetRGB(:,:,2);
buffet_interchannel(:,:,2) = buffetRGB(:,:,1);
imshow(buffet_interchannel)

subplot(1,2,1)
imshow(buffetRGB)
title('Color')
subplot(1,2,2)
imshow(buffet_interchannel)
title('Red <-> Green channels ')

imwrite(buffet_interchannel, 'channel_interchange.jpg')

% We observed that the green cabinet becomes red as well as the green vase.
% The green information has been swaped with the green information. 
% We also observed that the yellow sofa has changed colour slightly as the
% image has not a perfect balance of red and green channels. 
% The blackground has not changed at all. 

% 2.4
buffet_bluex0 = buffetRGB;
buffet_bluex0(:,:,3) = buffet_bluex0(:,:,3) * 0;

figure()
subplot(1,2,1)
imshow(buffetRGB)
title('Color')
subplot(1,2,2)
imshow(buffet_bluex0)
title('Blue channel deleted')

imwrite(buffet_bluex0, 'channelx0.jpg')

% Most of the blue information in the picture is contained in the white colour. 
% Thus, when the blue channel is deleted, the white colour changes to yellow.

