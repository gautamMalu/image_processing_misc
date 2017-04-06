function color_map_image = output_color_map(color_map,varargin)
% Function to output a color map in an image viewable format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Setup variables and parse command line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_p = inputParser;

i_p.addRequired('color_map',@(x)isnumeric(x));

i_p.addParameter('width',20,@(x)isnumeric(x));
i_p.addParameter('labels',0,@(x)length(x) == 2);

i_p.parse(color_map,varargin{:});

addpath(genpath('image_processing_misc'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Main Program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,color_map_image] = meshgrid(1:i_p.Results.width,(size(color_map)-1):-1:0);
color_map_image = ind2rgb(color_map_image,color_map);

if (not(strcmp(i_p.UsingDefaults,'labels')))
    color_map_image = insertText(color_map_image,...
        [size(color_map_image,2)/2,size(color_map_image,1)],...
        i_p.Results.labels(1),'FontSize',8,'BoxOpacity',0,...
        'AnchorPoint','CenterBottom','TextColor','white');
    
    color_map_image = insertText(color_map_image,[size(color_map_image,2)/2,1],...
        i_p.Results.labels(2),'FontSize',8,'BoxOpacity',0,...
        'AnchorPoint','CenterTop','TextColor','white');
end