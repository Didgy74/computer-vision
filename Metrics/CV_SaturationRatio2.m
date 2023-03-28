function output = CV_SaturationRatio2(original,distorted)
%CV_SATURATION Summary of this function goes here
%   Detailed explanation goes here
    
    orig_mean_sat = CV_MeanSaturation(original);

    distorted_mean_sat = CV_MeanSaturation(distorted);

    output = distorted_mean_sat / orig_mean_sat;
    
end


