function output = CV_MeanSaturationRatio(original,distorted)
    orig_mean_sat = CV_MeanSaturation(original);
    distorted_mean_sat = CV_MeanSaturation(distorted);

    output = distorted_mean_sat / orig_mean_sat;
    
end

