function [I,column, row] = FindProbableRegion(I,horz, vert, cols, rows,max_vert,max_horz);
    % Initialization
    j = 1;
    column = []; % Initialize column array
    row = []; % Initialize row array

    % Detection de region horizontal
    for i = 2:cols-2
        if(horz(i) ~= 0 && horz(i-1) == 0 && horz(i+1) == 0)
            column(j) = i;
            column(j+1) = i;
            j = j + 2;
        elseif((horz(i) ~= 0 && horz(i-1) == 0) || (horz(i) ~= 0 && horz(i+1) == 0))
            column(j) = i;
            j = j + 1;
        end
    end

    j = 1;
    % Detection de region verticale
    for i = 2:rows-2
        if(vert(i) ~= 0 && vert(i-1) == 0 && vert(i+1) == 0)
            row(j) = i;
            row(j+1) = i;
            j = j + 2;
        elseif((vert(i) ~= 0 && vert(i-1) == 0) || (vert(i) ~= 0 && vert(i+1) == 0))
            row(j) = i;
            j = j + 1;
        end
    end
    
    % Extraction des régions d'interet 

    % si la taille est paire on rajoute le nbr totel à la fin pour assurer
    % l'appariement
    [~, column_size] = size(column);
    if(mod(column_size, 2))
        column(column_size+1) = cols;
    end
    
    [~, row_size] = size(row);
    if(mod(row_size, 2))
        row(row_size+1) = rows;
    end
    % Parcours des liste column, et row
    for i = 1:2:row_size
        for j = 1:2:column_size
            % Si la région n'est pas la plus probable on la met à 0
            if(~((max_horz >= column(j) && max_horz <= column(j+1)) && (max_vert >=row(i) && max_vert <= row(i+1))))
            % Mise à 0
                for m = row(i):row(i+1)
                    for n = column(j):column(j+1)
                            I(m, n) = 0;
                    end
                end
            end
        end
    end
    figure(7), imshow(I);
    imshow(I);
end
