function cleaned_binary = remove_edge_objects(threshed_image)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup variables and parse command line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i_p = inputParser;

i_p.addRequired('threshed_image',@(x)isnumeric(x) || islogical(x));

i_p.parse(threshed_image);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

edge_border = ones(size(threshed_image));
edge_border = bwperim(edge_border);

[row_indexes,col_indexes] = ind2sub(size(threshed_image), find(edge_border));
edge_objects = bwselect(threshed_image,col_indexes,row_indexes,4);

cleaned_binary = threshed_image & not(edge_objects);
