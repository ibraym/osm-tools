function nodes = get_nodes(struc)
    % Extract the nodes data from the struct
    % input
    %   struc = MATLAB data structure of parsed OpenStreetMap file
    %
    % output
    %   nodes = MATLAB data table of the nodes in the OpenStreetMap file contains the
    %   following columns: id, lat, lon
    %
    % 2023.07.04 (c) Ibrahem Mouhamad, ibrahem.y.mouhamad@gmail.com
    %

    node_struct = struc.node;
    columns = {'idAttribute', 'latAttribute', 'lonAttribute'};
    node_fieldnames = fieldnames(node_struct);
    fields_to_remove = node_fieldnames(~ismember(node_fieldnames, columns));
    node_struct = rmfield(node_struct, fields_to_remove);
    nodes = struct2table(node_struct);
    nodes.Properties.VariableNames = {'id', 'lat', 'lon'};
end