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





