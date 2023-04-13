%function [sharpVal] = sharpness(srcImage)
%% Sharpness
% The program aims to calculate the sharpness of an image use the Brenner's
% focus measure. The measure must be used on grayscale images.
%
%   srcImage  -   the matrix representing the source image
%   sharpVal  -   calculated sharpness of image

% Open source images
I = imread ('final01.bmp');         
I2 = imread('final01_d1_l1.bmp');

figure ('Name','Colour images');
subplot (1,2,1);    imshow(I);      title('Original Colour image');
subplot (1,2,2);    imshow(I2);     title('Distorted Colour image');

% Convert the images to grayscale
J = rgb2gray(I);                    
J2= rgb2gray(I2); 

% Plot the images
figure ('Name', 'Grayscale Versions');
subplot (1,2,1);    imshow(J);      title('Original Grayscale image');
subplot (1,2,2);    imshow(J2);     title('Distorted Grayscale image');

[M, N] = size(J);           % M is the number of rows, N is columns

% Matrices for the Brenner focus measure at each pixel
brenner = zeros(M,N);       % Holds the Brenner score
brenner2 = zeros(M,N);

% Calculate the Brenner focus measure for each image
for x = 1:M
    for y = 1:N-2
        brenner(x,y) = (J(x, y+2) - J(x,y)).^2;
        brenner2(x,y) = (J2(x, y+2) - J2(x,y)).^2;
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

 % An image with a high Brenner score generally is more in-focus
 % than an image with a lower Brenner score. The image with a higher
 % score typically has more small-scale textures than the image with a 
 % lower score.
