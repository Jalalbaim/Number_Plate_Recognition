function [I, horz, max_horz] = processHorizontalEdges(I)
    % size image
    [rows, cols] = size(I);
    %initilaisation des parametres
    max_horz = 0;
    maximum = 0;
    total_sum = 0;
    horz1 = zeros(1, cols);

    for i = 2:cols
        sum = 0;
        for j = 2:rows
            if(I(j, i) > I(j-1, i))
                difference = uint32(I(j, i) - I(j-1, i));
            else
                difference = uint32(I(j-1, i) - I(j, i));
            end
            if(difference > 20)
                sum = sum + difference;
            end
        end
        horz1(i) = sum;
        % Find Peak Value
        if(sum > maximum)
            max_horz = i;
            maximum = sum;
        end
        total_sum = total_sum + sum;
    end
    average = total_sum / cols;

    % Plotting
    figure(4);
    subplot(3,1,1);
    plot(horz1);
    title('Horizontal Edge Processing Histogram');
    xlabel('Column Number ->');
    ylabel('Difference ->');

    % Smoothen the Horizontal Histogram by applying Low Pass Filter
    horz = horz1;
    for i = 21:(cols-21)
        sum = 0;
        for j = (i-20):(i+20)
            sum = sum + horz1(j);
        end
        horz(i) = sum / 41;
    end
    subplot(3,1,2);
    plot(horz);
    title('Histogram after passing through Low Pass Filter');
    xlabel('Column Number ->');
    ylabel('Difference ->');

    % Filter out Horizontal Histogram Values by applying Dynamic Threshold
    disp('Filter out Horizontal Histogram...');
    for i = 1:cols
        if(horz(i) < average)
            horz(i) = 0;
            for j = 1:rows
                I(j, i) = 0;
            end
        end
    end
    subplot(3,1,3);
    plot(horz);
    title('Histogram after Filtering');
    xlabel('Column Number ->');
    ylabel('Difference ->');
end
