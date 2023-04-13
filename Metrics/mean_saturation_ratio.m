function output = mean_saturation_ratio(original,distorted)
    orig_mean_sat = CV_MeanSaturation(original);
    distorted_mean_sat = CV_MeanSaturation(distorted);

    output = distorted_mean_sat / orig_mean_sat;
    
end

