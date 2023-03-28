function output = CV_MeanSaturation(img)
%CV_MEANSATURATION Summary of this function goes here
%   Detailed explanation goes here

    hsv = rgb2hsv(img);
    all_sat = hsv(:, :, 2);
    output = mean(all_sat, 'all');

end

