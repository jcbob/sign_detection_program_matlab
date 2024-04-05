% Funkcja usuwająca plamy nie spełniające kryteriów
function filtered_regions = filter_regions(regions, max_size_threshold, min_region_size2)
    filtered_regions = [];
    for r = 1:length(regions)
        region_size = (regions(r).max_row - regions(r).min_row + 1) * (regions(r).max_col - regions(r).min_col + 1);
        width_height_ratio = (regions(r).max_col - regions(r).min_col + 1) / (regions(r).max_row - regions(r).min_row + 1);
        height_width_ratio = 1 / width_height_ratio; % Stosunek wysokości do szerokości
        
        % Warunek 1: Usuń plamy zbyt małe
        if region_size >= min_region_size2
            % Warunek 2: Usuń plamy zbyt duże
            if region_size <= max_size_threshold
                % Warunek 3: Usuń plamy z nieprawidłowym stosunkiem szerokości do wysokości
                aspect_ratio_tolerance = 0.3; % Dopuszczalny zakres odstępstwa od idealnego stosunku
                ideal_ratio = 1.0; % Idealny stosunek (kwadrat)
                if (abs(width_height_ratio - ideal_ratio) <= aspect_ratio_tolerance) && (height_width_ratio >= 0.6) && (height_width_ratio <= 1.3)
                    filtered_regions = [filtered_regions, regions(r)];
                end
            end
        end
    end
end
