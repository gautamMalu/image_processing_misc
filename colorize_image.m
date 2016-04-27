function color_image = colorize_image(image,color_map,varargin)
% Function to convert an image to color image, with a given color map.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Setup variables and parse command line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_p = inputParser;

i_p.addRequired('image',@(x)isnumeric(x));

i_p.addRequired('color_map',@(x)isnumeric(x));

i_p.addParameter('normalization_limits',0,@(x)isnumeric(x) & length(x) == 2)
i_p.addParameter('quantile_limits',0,@(x)isnumeric(x) & length(x) == 2)

i_p.parse(image,color_map,varargin{:});

addpath(genpath('image_processing_misc'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Main Program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (i_p.Results.normalization_limits ~= 0)
    image_norm = normalize_image(image,'limits',i_p.Results.normalization_limits);
    image_norm(image > i_p.Results.normalization_limits(2)) = 0;
elseif (i_p.Results.quantile_limits ~= 0)
    [image_norm,limits] = normalize_image(image,...
        'quantile',i_p.Results.quantile_limits,'only_nonzero',1);
    image_norm(image > limits(2)) = 0;
else    
    image_norm = normalize_image(image);
end

image_norm = uint16(round(image_norm .* size(color_map,1)));

color_image = ind2rgb(image_norm,color_map);
