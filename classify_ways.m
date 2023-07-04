function classified_ways = classify_ways(ways)
    % Classify the ways by adding primary and secondary categories such as
    % building or highway
    %
    % input
    %   ways = MATLAB data table of ways from the parsed OpenStreetMap file contains the
    %   following columns: id, timestamp, node_ids, tags
    %
    % output
    %   classified_way = MATLAB data table of ways from the parsed OpenStreetMap file contains the
    %   following columns: id, timestamp, node_ids, tags, primary_category, secondary_category
    %
    % 2023.07.04 (c) Ibrahem Mouhamad, ibrahem.y.mouhamad@gmail.com
    %

    way_ids = string.empty(height(ways),0);
    tag_keys = string.empty(height(ways),0);
    tag_values = string.empty(height(ways),0);
    for i = 1:height(ways)
        way_ids(i) = ways.id(i);
        tags = ways.tags{i,1};
        tags_table = struct2table(tags);
        % We want to extract the highways and buildings 
        tmp = tags_table(tags_table.kAttribute == 'building' | tags_table.kAttribute == 'highway', :);
        if height(tmp) == 1
            tag_keys(i) = tmp{1, 1};
            tag_values(i) = tmp{1, 2};
        else 
            tag_keys(i) = '';
            tag_values(i) = '';
        end
    end
    categories_table  = table(way_ids', tag_keys', tag_values');
    categories_table.Properties.VariableNames = {'id', 'primary_category', 'secondary_category'};
    classified_ways = join(ways, categories_table, ...
        'LeftKeys','id', 'RightKeys','id');
    classified_ways(classified_ways.primary_category == "", :) = [];
end