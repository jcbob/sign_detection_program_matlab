function min_region_size = calculate_region_size(height, width, percent_of_image)
    % Obliczanie minimalnego rozmiaru regionu na podstawie procentowej wartości
    total_pixels = height * width;
    min_region_size = round(percent_of_image / 100 * total_pixels);
end