function struc = osm_to_struct(filename)
    % load OpenStreetMap file contents as a MATLAB structure
    % input
    %   filename = string of OpenStreetMap XML Data file name, file
    %   extension could be .osm or .xml
    %
    % output
    %   struc = MATLAB data structure of parsed OpenStreetMap file
    %
    % 2023.07.04 (c) Ibrahem Mouhamad, ibrahem.y.mouhamad@gmail.com
    %
    
    [~, ~, extension] = fileparts(filename);
    if extension == ".xml" || extension == ".osm"
        struc = readstruct(filename,'FileType','xml');
    else
        E = MException('OSMTools:UnsupportedFileType', 'file must be an ".osm" or ".xml" file');
        throw(E);
    end
    % Remove unnecessary fields from struct
    fields = {'generatorAttribute', 'versionAttribute'};
    struc = rmfield(struc, fields);
end