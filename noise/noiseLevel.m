function out = noiseLevel(img)

    %Load the pretrained denoising convolutional neural network, 'DnCNN'.
    net = denoisingNetwork('DnCNN');

    %convert the image to grascale
    img = im2gray(img);

    %create the denoised image
    denoisedI = denoiseImage(img,net);

    %calculate the difference between the denoised image and the original
    %input image
    diff = img - denoisedI;

    %get the average of the difference
    out = mean(diff(:));
