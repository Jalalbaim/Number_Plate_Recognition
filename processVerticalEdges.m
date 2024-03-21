function [I, vert, maximum, max_vert] = processVerticalEdges(I)
    % Initialize variables
    [rows, cols] = size(I);
    difference = 0;
    total_sum = 0;
    difference = uint32(difference);
    disp('Processing Edges Vertically...');
    maximum = 0;
    max_vert = 0;
    vert1 = zeros(1, rows);
    
    % Process edges in vertical direction
    for i = 2:rows
        sum = 0;
        for j = 2:cols
            if(I(i, j) > I(i, j-1))
                difference = uint32(I(i, j) - I(i, j-1));
            else
                difference = uint32(I(i, j-1) - I(i, j));
            end
            if(difference > 20)
                sum = sum + difference;
            end
        end
        vert1(i) = sum;

        % Find peak in vertical histogram
        if(sum > maximum)
            max_vert = i;
            maximum = sum;
        end
        total_sum = total_sum + sum;
    end
    
    % Calculate average
    average = total_sum / rows;
    
    % Display histogram
    figure(5);
    subplot(3,1,1);
    plot(vert1);
    title('Vertical Edge Processing Histogram');
    xlabel('Row Number ->');
    ylabel('Difference ->');

    % Smoothen the vertical histogram
    disp('Passing Vertical Histogram through Low Pass Filter...');
    sum = 0;
    vert = vert1;
    for i = 21:(rows-21)
        sum = 0;
        for j = (i-20):(i+20)
            sum = sum + vert1(j);
        end
        vert(i) = sum / 41;
    end
    subplot(3,1,2);
    plot(vert);
    title('Histogram after passing through Low Pass Filter');
    xlabel('Row Number ->');
    ylabel('Difference ->');

    % Filter out vertical histogram values
    disp('Filter out Vertical Histogram...');
    for i = 1:rows
        if(vert(i) < average)
            vert(i) = 0;
            for j = 1:cols
                I(i, j) = 0;
            end
        end
    end
    subplot(3,1,3);
    plot(vert);
    title('Histogram after Filtering');
    xlabel('Row Number ->');
    ylabel('Difference ->');

    % Show final image
    figure(6), imshow(I);
end
