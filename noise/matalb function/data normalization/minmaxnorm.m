function out = minmaxnorm(value)
%normalize the input values using the min-max normalization (feature
%scaling) to get values between 0 and 5. (Note: the min and max value are
%calculated from a sample data, which means that come values could be
%larger or samller that the max and min, these values are set to 0(for
%values smaller than min) and 5(for values larger than max). This might
%slightly affect the integrity if the normalization but should not be a big
%concern since it is only sensitive to extreme values with low occurence
%probability

%the min and max values calculated from the test data set
max = 211.6501;
min = 0.8049;

%min-max normalization equation
normalized = ((value-min)/(max - min))*5;

%checking for extreme values befor returning the results
if normalized > 5 %incase of abnormally high values
    out = 5;
elseif normalized < 0 % in case of abnormally low values
    out = 0;
else
    out = normalized;
end

