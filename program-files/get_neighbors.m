function neighbors = get_neighbors(point, rows, cols)
    % Pobranie współrzędnych sąsiadów punktu
    row = point(1);
    col = point(2);
    
    neighbors = [row-1, col;
                 row+1, col;
                 row, col-1;
                 row, col+1];
    
    % Usunięcie sąsiadów spoza zakresu obrazu
    out_of_bounds = (neighbors(:, 1) < 1) | (neighbors(:, 1) > rows) | (neighbors(:, 2) < 1) | (neighbors(:, 2) > cols);
    neighbors(out_of_bounds, :) = [];
end


