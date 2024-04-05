% Funkcja sprawdzająca, czy jeden region zawiera się w znacznej mierze w drugim
function inside = is_inside(region1, region2)
    inside = region1.min_row >= region2.min_row && region1.max_row <= region2.max_row && ...
             region1.min_col >= region2.min_col && region1.max_col <= region2.max_col;
end