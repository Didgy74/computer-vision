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
