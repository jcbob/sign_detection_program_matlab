% Funkcja łącząca dwa regiony
function merged_region = merge_regions(region1, region2)
    merged_region = struct();
    merged_region.points = [region1.points; region2.points];
    merged_region.min_row = min(region1.min_row, region2.min_row);
    merged_region.max_row = max(region1.max_row, region2.max_row);
    merged_region.min_col = min(region1.min_col, region2.min_col);
    merged_region.max_col = max(region1.max_col, region2.max_col);
end