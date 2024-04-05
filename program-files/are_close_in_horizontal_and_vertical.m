% Funkcja sprawdzająca, czy dwa regiony są względnie blisko siebie w poziomie i jednocześnie położone podobnie w pionie
function close = are_close_in_horizontal_and_vertical(region1, region2, some_threshold)
    horizontal_distance = abs((region1.min_col + region1.max_col) / 2 - (region2.min_col + region2.max_col) / 2);
    vertical_distance = abs((region1.min_row + region1.max_row) / 2 - (region2.min_row + region2.max_row) / 2);
    
    close = horizontal_distance < some_threshold && vertical_distance < some_threshold;
end