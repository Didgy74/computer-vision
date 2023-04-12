function score = totalNoise(~, dis_img)
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

