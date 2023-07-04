function bounding_box = get_bounds(struc)
    % Extract the bounding box from the struct
    % input
    %   struc = MATLAB data structure of parsed OpenStreetMap file
    %
    % output
    %   bounding_box = MATLAB polyshape structure that defines the boundry
    %   of the map
    %
    % 2023.07.04 (c) Ibrahem Mouhamad, ibrahem.y.mouhamad@gmail.com
    %

    mxlat = struc.bounds.maxlatAttribute;
    mxlon = struc.bounds.maxlonAttribute;
    mnlat = struc.bounds.minlatAttribute;
    mnlon = struc.bounds.minlonAttribute;
    bounding_box = polyshape([mxlat, mxlat, mnlat, mnlat], [mnlon, mxlon, mxlon, mnlon]);
end