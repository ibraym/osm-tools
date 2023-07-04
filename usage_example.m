% Load OSM file
osm_file = openstreetmap_filename;
struc = osm_to_struct(osm_file);

% Extract ways and filter by building category
ways = get_ways(struc);
ways = clean_ways(ways);
classified_ways = classify_ways(ways);
buildings = filter_by_category(classified_ways, 'building');

% Get nodes and build geo shapes
nodes = get_nodes(struc);
bounding_box = get_bounds(struc);
disp(bounding_box)
shaped_buildings = build_geo_shapes(buildings, nodes);

% Get building heights
heights = zeros(1, height(buildings));
for i = 1:(height(buildings))
    building = buildings(i,:);
    tags = building.tags{1};
    tags_table = struct2table(tags);
    tmp = tags_table(tags_table.kAttribute == 'height', :);
    if height(tmp) == 1
       heights(i) = str2double(tmp.vAttribute{1});
    else
        tmp = tags_table(tags_table.kAttribute == "building:levels", :);
        if height(tmp) == 1
            heights(i) = str2double(tmp.vAttribute{1})*3;
        else
            heights(i) = 1;
        end
    end
end

% Plot buildings with in different colors based on their hieghts
geoplot(shaped_buildings.shapes, ColorData=heights);
colorbar;

