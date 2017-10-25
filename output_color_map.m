function color_map_image = output_color_map(color_map,varargin)
% Function to output a color map in an image viewable format
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Setup variables and parse command line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_p = inputParser;

i_p.addRequired('color_map',@(x)isnumeric(x));

i_p.addParameter('width',20,@(x)isnumeric(x));
i_p.addParameter('labels',0,@(x)length(x) == 2);
i_p.addParameter('label_colors',{'white','white'},...
    @(x)iscell(x) & length(x) == 2)

i_p.parse(color_map,varargin{:});

addpath(genpath('image_processing_misc'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Main Program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~,color_map_image] = meshgrid(1:i_p.Results.width,(size(color_map)-1):-1:0);
color_map_image = ind2rgb(color_map_image,color_map);

color_map_image = imrotate(color_map_image,90);

if (not(strcmp(i_p.UsingDefaults,'labels')))
    color_map_image = insertText(color_map_image,...
        [1,size(color_map_image,1)/2],...
        i_p.Results.labels(2),'FontSize',12,'BoxOpacity',0,...
        'AnchorPoint','LeftCenter',...
        'TextColor',i_p.Results.label_colors{1});
    
    color_map_image = insertText(color_map_image,...
        [size(color_map_image,2),size(color_map_image,1)/2],...
        i_p.Results.labels(1),'FontSize',12,'BoxOpacity',0,...
        'AnchorPoint','RightCenter',...
        'TextColor',i_p.Results.label_colors{2});
end