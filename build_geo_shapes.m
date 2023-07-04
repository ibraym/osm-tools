function shaped_ways = build_geo_shapes(classified_ways, nodes)
    % Build the geographical shapes from ways table based on the primary_category
    %
    % input
    %   classified_ways = MATLAB data table of ways from the parsed OpenStreetMap file contains the
    %   following columns: id, timestamp, node_ids, tags, primary_category, secondary_category
    %
    % output
    %   shaped_ways = classified_ways table with aditional column that
    %   contains the geo shape
    %
    % 2023.07.04 (c) Ibrahem Mouhamad, ibrahem.y.mouhamad@gmail.com
    %

    shapes_cell = {};
    for i = 1:(height(classified_ways))
        way = classified_ways(i,:);
        way_nodes = way.node_ids;
        nodesOjb = struct2table(way_nodes{1});
        nodesOjb.index = (1:height(nodesOjb)).';
        % Get the nodes coordinates by joinging nodesOjb with nodes table
        coordinates = innerjoin( nodesOjb, nodes, "LeftKeys", "refAttribute", "RightKeys",...
            "id");
        coordinates = sortrows(coordinates, "index");
        % build shapes based on category
        category = way.primary_category;
        if category == "highway"
            shapes = geolineshape(coordinates.lat, coordinates.lon);
        elseif category == "building"
            shapes = geopolyshape(coordinates.lat, coordinates.lon);
        end 
        shapes = {shapes};
        shapes_cell(i) = shapes;
    end
    shapes_table = cell2table(shapes_cell');
    shaped_ways = [classified_ways, shapes_table];
    % rename last column to shapes for readability
    shaped_ways.Properties.VariableNames = {'id', 'timestamp', 'node_ids', 'tags', 'primary_category', 'secondary_category', 'shapes'};
end