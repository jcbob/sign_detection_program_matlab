function detected_regions = detect_regions(binary_image, min_region_size, join_region_threshold, max_region_size, min_region_size2)
    % Inicjalizacja listy wykrytych regionów/plam
    detected_regions = [];
    
    % Przejście przez obraz binarny
    [rows, cols] = size(binary_image);
    for i = 1:2:rows
        for j = 1:2:cols
            % Jeśli natrafimy na biały piksel, rozpoczynamy nową plamę
            if binary_image(i, j) == 1
                region = struct();
                region.points = [i, j]; % Punkt początkowy plamy
                region.min_row = i;
                region.max_row = i;
                region.min_col = j;
                region.max_col = j;
                
                % Ustawienie barwy piksela na czarną
                binary_image(i, j) = 0;
                
                % Dodanie punktu do listy punktów do zbadania
                points_to_check = [i, j];
                
                % Dopóki są punkty do zbadania
                while ~isempty(points_to_check)
                    point = points_to_check(1, :);
                    points_to_check(1, :) = []; % Usunięcie pierwszego punktu
                    
                    % Sprawdzenie sąsiadów punktu
                    neighbors = get_neighbors(point, rows, cols);
                    for k = 1:size(neighbors, 1)
                        neighbor_row = neighbors(k, 1);
                        neighbor_col = neighbors(k, 2);
                        
                        % Jeśli sąsiad jest biały
                        if binary_image(neighbor_row, neighbor_col) == 1
                            % Ustawienie barwy piksela na czarną
                            binary_image(neighbor_row, neighbor_col) = 0;
                            
                            % Dodanie sąsiada do listy punktów do zbadania
                            points_to_check = [points_to_check; neighbor_row, neighbor_col];
                            
                            % Aktualizacja granic opisujących plamę
                            region.min_row = min(region.min_row, neighbor_row);
                            region.max_row = max(region.max_row, neighbor_row);
                            region.min_col = min(region.min_col, neighbor_col);
                            region.max_col = max(region.max_col, neighbor_col);
                        end
                    end
                end


                % Analiza i aktualizacja znalezionych plam/regionów
                % Odrzucenie małych regionów
                region_size = (region.max_row - region.min_row + 1) * (region.max_col - region.min_col + 1);
                if region_size >= min_region_size
                    % Sprawdzenie warunków łączenia z innymi regionami
                    merged = false;
                    for r = 1:length(detected_regions)
                        % Warunek 1: jeden region zawiera się w znacznej mierze w drugim
                        if is_inside(region, detected_regions(r))
                            % Połączenie regionów
                            detected_regions(r) = merge_regions(detected_regions(r), region);
                            merged = true;
                            % merged = false;
                            break;
                        end

                        % Warunek 2: są względnie blisko siebie w poziomie i jednocześnie położone podobnie w pionie
                        if are_close_in_horizontal_and_vertical(region, detected_regions(r), join_region_threshold)
                            % Połączenie regionów
                            detected_regions(r) = merge_regions(detected_regions(r), region);
                            merged = true;
                            % merged = false;
                            break;
                        end

                        % Warunek 3: są względnie blisko siebie w pionie i jednocześnie położone podobnie w poziomie
                        if are_close_in_vertical_and_horizontal(region, detected_regions(r), join_region_threshold)
                            % Połączenie regionów
                            detected_regions(r) = merge_regions(detected_regions(r), region);
                            merged = true;
                            % merged = false;
                            break;
                        end
                    end

                    % Jeśli nie został połączony z żadnym istniejącym regionem, dodaj go do listy
                    if ~merged
                        detected_regions = [detected_regions, region];
                    end
                end
            end
        end
    end

    % Usunięcie plam, które nie spełniają kryteriów
    detected_regions = filter_regions(detected_regions, max_region_size, min_region_size2);
end