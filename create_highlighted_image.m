function high_image = create_highlighted_image(image,high,varargin)
%CREATE_HIGHLIGHTED_IMAGE    add highlights to an image
%
%   H_I = create_highlighted_image(I,HIGHLIGHTS) adds green highlights to
%   image 'image', using the binary image 'HIGHLIGHTS' as the guide
%
%   H_I = create_highlighted_image(image,HIGHLIGHTS,'color_map',[R,G,B]) adds
%   highlights of color specified by the RGB sequence '[R,G,B]' to image
%   'image', using the binary image 'HIGHLIGHTS' as the guide

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Setup variables and parse command line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_p = inputParser;
i_p.FunctionName = 'CREATE_HIGHLIGHTED_IMAGE';

i_p.addRequired('image',@(x)isnumeric(x) || islogical(x));
i_p.addRequired('high',@(x)(isnumeric(x) || islogical(x)));

i_p.parse(image,high);

i_p.addParameter('color_map',jet(double(max(high(:)))),@(x)(all(high(:) == 0) || (isnumeric(x) && (size(x,1) >= max(unique(high))))));
i_p.addParameter('mix_percent',1,@(x)(isnumeric(x)));

i_p.parse(image,high,varargin{:});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Main Program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
image_size = size(image);

if (size(image_size) < 3)
    high_image_red = image;
    high_image_green = image;
    high_image_blue = image;
else
    high_image_red = image(:,:,1);
    high_image_green = image(:,:,2);
    high_image_blue = image(:,:,3);
end

if (all(high(:) == 0))
    high_image = cat(3,high_image_red,high_image_green,high_image_blue);
    return
end

labels = unique(high);
assert(labels(1) == 0,'Looks like the image doesn''t have any labels.')
labels = labels(2:end);

for i=1:length(labels)
    indexes = high == labels(i);
    
    this_cmap = i_p.Results.color_map(labels(i),:);
    
    high_image_red(indexes) = this_cmap(1)*i_p.Results.mix_percent + high_image_red(indexes)*(1-i_p.Results.mix_percent);
    high_image_green(indexes) = this_cmap(2)*i_p.Results.mix_percent + high_image_green(indexes)*(1-i_p.Results.mix_percent);
    high_image_blue(indexes) = this_cmap(3)*i_p.Results.mix_percent + high_image_blue(indexes)*(1-i_p.Results.mix_percent);
end

high_image = cat(3,high_image_red,high_image_green,high_image_blue);

end
