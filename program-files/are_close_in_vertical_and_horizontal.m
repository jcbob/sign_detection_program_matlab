% Funkcja sprawdzająca, czy dwa regiony są względnie blisko siebie w pionie i jednocześnie położone podobnie w poziomie
function close = are_close_in_vertical_and_horizontal(region1, region2, some_threshold)
    vertical_distance = abs((region1.min_row + region1.max_row) / 2 - (region2.min_row + region2.max_row) / 2);
    horizontal_distance = abs((region1.min_col + region1.max_col) / 2 - (region2.min_col + region2.max_col) / 2);
    
    close = vertical_distance < some_threshold && horizontal_distance < some_threshold;
end