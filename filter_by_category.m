function category_table = filter_by_category(classified_ways, category)
    % Filter ways table based on the primary category
    %
    % input
    %   classified_ways = MATLAB data table of ways from the parsed OpenStreetMap file contains the
    %   following columns: id, timestamp, node_ids, tags, primary_category, secondary_category
    %   category =  the category to filter such as building or highway
    %
    % output
    %   category_table = filtered classified_ways table 
    %
    % 2023.07.04 (c) Ibrahem Mouhamad, ibrahem.y.mouhamad@gmail.com
    %
    category_table = classified_ways((classified_ways.primary_category == category),:);
end