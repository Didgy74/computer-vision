function output = mean_saturation(img)
    hsv = rgb2hsv(img);
    all_sat = hsv(:, :, 2);
    output = mean(all_sat, 'all');
end

