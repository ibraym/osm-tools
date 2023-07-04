function ways = get_ways(struc)
    % Extract the ways data from the struct
    % input
    %   struc = MATLAB data structure of parsed OpenStreetMap file
    %
    % output
    %   ways = MATLAB data table of the ways in the OpenStreetMap file contains the
    %   following columns: id, timestamp, node_ids, tags
    %
    % 2023.07.04 (c) Ibrahem Mouhamad, ibrahem.y.mouhamad@gmail.com
    %

    way_struct = struc.way;
    columns = {'idAttribute', 'timestampAttribute', 'nd', 'tag'};
    way_fieldnames = fieldnames(way_struct);
    fields_to_remove = way_fieldnames(~ismember(way_fieldnames, columns));
    way_struct = rmfield(way_struct, fields_to_remove);
    ways = struct2table(way_struct);
    ways.timestampAttribute = datetime(extractBetween(ways.timestampAttribute, 1, 10));
    ways.Properties.VariableNames = {'id', 'timestamp', 'node_ids', 'tags'};
end