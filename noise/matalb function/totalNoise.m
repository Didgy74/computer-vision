function resutl = totalNoise(img)

    %separate the image into red, green, and blue color channels
    imgRed = img(:,:, 1);
    imgGreen = img(:,:,2);
    imgBlue = img(:,:, 3);
    
    %get the noise level in each channel
    redNoise = noiseLevel(imgRed);
    greenNoise = noiseLevel(imgGreen);
    blueNoise = noiseLevel(imgBlue);
    
    %calculate the mean of the noise in the three channles
    resutl = (redNoise + greenNoise + blueNoise)/3;
end

