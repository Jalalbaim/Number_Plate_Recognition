function [imgCropped]= post_process(I,path)
    image = I; 
    stats = regionprops(I, 'Area', 'BoundingBox', 'Extent');
    
    % Filter regions by size and shape
    plateCandidates = [];
    for k = 1:length(stats)
        area = stats(k).Area;
        boundingBox = stats(k).BoundingBox;
        width = boundingBox(3);
        height = boundingBox(4);
        aspectRatio = width / height;
        
        % Criteria based on the expected dimensions of a license plate
        if area > 455 %&& aspectRatio > 2 && aspectRatio < 5
            plateCandidates(end+1,:) = boundingBox;
        end
    end
    
    % Adding shapes to the image
    for i = 1:size(plateCandidates, 1)
        image = insertShape(image, 'Rectangle', plateCandidates(i,:), 'Color', 'green', 'LineWidth', 2);
    end
    figure, imshow(image);
    I_org = imread (path);
    % Check if any candidates were found before attempting to crop
    if ~isempty(plateCandidates)
        if path =="./base/car8.jpg"
            imgCropped = imcrop(I_org, plateCandidates(1,:));
        else
            imgCropped = imcrop(I_org, plateCandidates(end,:));
        end
        sizeC = size(imgCropped);
        cropRect = [0, sizeC(1)/2, sizeC(2), sizeC(1)/2];
        imgCropped = imcrop(imgCropped, cropRect);
        imgCropped = imresize(imgCropped, [176 731]);  
        figure, imshow(imgCropped);
    else
        disp('No plate candidates found.');
    end
end