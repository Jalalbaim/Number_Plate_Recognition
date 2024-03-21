function [Igray, Idilate] = pre_process(chemin)
    % Read the image
    I = imread(chemin);

    % Display the original image
    figure(1);
    imshow(I);

    % Convert to grayscale
    Igray = rgb2gray(I);

    % Dilate the image
    Idilate = imdilate(Igray,strel("line",3,0));
    % Display grayscale and dilated images
    figure(2);
    imshow(Igray);
    title('Grayscale Image');

    figure(3);
    imshow(Idilate);
    title('Dilated Image');

end
