function [output] = CV_SaturationRangeRatio(orig,distorted)
    originalRange = cv_imsatrange(orig);
    distortedRange = cv_imsatrange(distorted);

    output = double(distortedRange) / double(originalRange);
end

function [satRange] = cv_imsatrange(inputImg)
    asHsv = rgb2hsv(inputImg);
    sat = asHsv(:, :, 2);
    
    minValue = uint8(round(min(sat,[],"all") * 255));
    maxValue = uint8(round(max(sat,[],"all") * 255));

    satRange = maxValue - minValue;
end

