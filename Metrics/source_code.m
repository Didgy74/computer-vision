function [uniformityScore] = contrast_score(img1,img2)
	%This function returns 2 values as contrast is decided by uniform
	%distribution
	%and difference spread/span of intensities

	%converts picture to grayscale for histogram manip
	%oImg = rgb2gray(img); 
	%oImg = imread("lowContrastImage");
	%oImg = imread("liftingbody.png");
	oImg = im2gray(img1);
	oHist = imhist(oImg);

	%figure, bar(oHist); title("histogram");

	%find average intensity

	averageInten = sum(oHist)/256;
	%pixels off a perfectly uniform distribution(completely flat histogram)
	pixOffUniform = uint16(0);
	for i=1:size(oHist)
		if(oHist(i)<averageInten)
			pixOffUniform = pixOffUniform + averageInten-oHist(i);
		end

		if(oHist(i)>averageInten)
			pixOffUniform = pixOffUniform + oHist(i)-averageInten;
		end
	end
	% off_uniform/total number of pixels
	uniformityScore1 = 1-(double(pixOffUniform)/(size(oImg, 1)*size(oImg, 2)));


	%% image nr 2
	%This function returns 2 values as contrast is decided by uniform
	%distribution
	%and difference spread/span of intensities

	%converts picture to grayscale for histogram manip
	%oImg = rgb2gray(img); 
	%oImg = imread("lowContrastImage");
	%oImg = imread("liftingbody.png");
	oImg = im2gray(img2);
	oHist = imhist(oImg);

	%figure, bar(oHist); title("histogram");

	%find average intensity

	averageInten = sum(oHist)/256;
	%pixels off a perfectly uniform distribution(completely flat histogram)
	pixOffUniform = uint16(0);
	for i=1:size(oHist)
		if(oHist(i)<averageInten)
			pixOffUniform = pixOffUniform + averageInten-oHist(i);
		end

		if(oHist(i)>averageInten)
			pixOffUniform = pixOffUniform + oHist(i)-averageInten;
		end
	end
	% off_uniform/total number of pixels
	uniformityScore2 = 1-(double(pixOffUniform)/(size(oImg, 1)*size(oImg, 2)));


	uniformityScore = uniformityScore2/uniformityScore1;

end

function output = mean_saturation(img)
	%% Calculate the mean saturation of an image. 
	% Returns a single double in the range [0, 1].
	
    hsv = rgb2hsv(img);
	% Extract all the saturations values.
    all_sat = hsv(:, :, 2);
    output = mean(all_sat, 'all');
end

function output = mean_saturation_diff_abs(original,distorted)
	%% Calculates the distance (absolute difference) between
	% the mean saturation of two images.
	%
	% Returns a double.
	
    orig_mean_sat = CV_MeanSaturation(original);
    distorted_mean_sat = CV_MeanSaturation(distorted);
    output = abs(distorted_mean_sat - orig_mean_sat);
end

function output = mean_saturation_ratio(original,distorted)
 	%% Calculates the ratio between
	% the mean saturation of two images.
	%
	% Returns a double.
	
    orig_mean_sat = CV_MeanSaturation(original);
    distorted_mean_sat = CV_MeanSaturation(distorted);
    output = distorted_mean_sat / orig_mean_sat;
	
	% We can always assume the distorted is worse, and so we
	% guarantee any deviation from the original results in a lower score.
	if output > 1 
		output = 1 / output;
	end
end

function [satRange] = cv_imsatrange(inputImg)
	%% Calculates the range of saturation shades in the given image.
	% Returns a uint8.

    asHsv = rgb2hsv(inputImg);
    sat = asHsv(:, :, 2);
    
    minValue = uint8(round(min(sat,[],"all") * 255));
    maxValue = uint8(round(max(sat,[],"all") * 255));

    satRange = maxValue - minValue;
end

function [output] = saturation_range_ratio(orig,distorted)
    originalRange = cv_imsatrange(orig);
    distortedRange = cv_imsatrange(distorted);
    output = double(distortedRange) / double(originalRange);
	
	% We can always assume the distorted is worse, and so we
	% guarantee any deviation from the original results in a lower score.
	if output > 1 
		output = 1 / output;
	end
end

function output = sharpness(original, distorted)
	%% Sharpness: Calculates sharpness in an image
	% The program aims to calculate the sharpness of an image use the Brenner's
	% focus measure. The measure must be used on grayscale images.
	%
	%   original    -   The matrix representing the source image
	%   distorted   -   The matrix representing the distorted image
	%   output      -   calculated difference in sharpness between images

	J = original;
	J2 = distorted;

	[M, N] = size(J);           % M is the number of rows, N is columns

	% Matrices for the Brenner focus measure at each pixel
	brenner = zeros(M,N);       % Holds the Brenner score
	brenner2 = zeros(M,N);

	% Calculate the Brenner focus measure for each image
	for x = 1:M
		for y = 1:N-2
			brenner(y,x) = (J(y+2, x) - J(y,x)).^2;
			brenner2(y,x) = (J2(y+2,x) - J2(y,x)).^2;
		end
	end

	% Sum the Brenner scores
	 S1 = sum(brenner, "all");
	 S2 = sum(brenner2, "all");

	% Calculate average Brenner scores
	S1_avg = S1/(M*N);
	S2_avg = S2/(M*N);

	 % Find the difference in Brenner focus measures
	 S3 = S1-S2;
	 
	 % Find the difference in average Brenner focus measures:
	 S3_avg = S3/(M*N);

	 output = S3_avg;   % Records output value

	 % An image with a high Brenner score generally is more in-focus
	 % than an image with a lower Brenner score. The image with a higher
	 % score typically has more small-scale textures than the image with a 
	 % lower score.
end

function score = total_noise(~, dis_img)
    %Load the pretrained denoising convolutional neural network, 'DnCNN'.
    net = denoisingNetwork('DnCNN'); 

    %separate the image into red, green, and blue color channels and
    %denoise them separately
    denoisedRed = denoiseImage(dis_img(:,:, 1),net);
    denoiusedGreen = denoiseImage(dis_img(:,:,2),net);
    denoisedBlue = denoiseImage(dis_img(:,:, 3),net);
    
    % separate the color channels of the distorted image for comparison
    or_red = dis_img(:,:, 1);
    or_green = dis_img(:,:, 2);
    or_blue = dis_img(:,:, 3);

    %get the average of the difference
    redNoise = immse(or_red(:), denoisedRed(:));
    greenNoise = immse(or_green(:), denoiusedGreen(:));
    blueNoise = immse(or_blue(:), denoisedBlue(:));

    %calculate the mean of the noise in the three channles
    score = (redNoise + greenNoise + blueNoise)/3;
end