function output = CV_SaturationDiff(original,distorted)
%CV_SATURATION Summary of this function goes here
%   Detailed explanation goes here
    
    orig_mean_sat = CV_MeanSaturation(original);

    distorted_mean_sat = CV_MeanSaturation(distorted);

    output = orig_mean_sat - distorted_mean_sat;
   
end