function cleaned_ways = clean_ways(ways)
    % Removes any ways that do not have associated tags
    % input
    %   ways = MATLAB data table of ways from the parsed OpenStreetMap file contains the
    %   following columns: id, timestamp, node_ids, tags
    %
    % output
    %   cleaned_ways = MATLAB data table of the ways in the OpenStreetMap file contains the
    %   following columns: id, timestamp, node_ids, tags
    %
    % 2023.07.04 (c) Ibrahem Mouhamad, ibrahem.y.mouhamad@gmail.com
    %

    tags_number = zeros(height(ways), 1);
    for i = 1:(height(ways))
        tags_number(i) = length(fieldnames(ways.tags{i,1}));
    end
    tags_number = array2table(tags_number);
    ways = [ways tags_number];
    cleaned_ways = ways(ways.tags_number > 0, 1:4);
end