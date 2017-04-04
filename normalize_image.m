function [image,varargout] = normalize_image(image,varargin)
%normalize_image    normalize an image to between 0-1
%
%   norm = normalize_image(I) normalizes the image so the minumum value is
%   now 0 and the maximum value is now 1
%
%   norm = normalize_image(I,'quantiles',[Q1,Q2]) normalizes the image so
%   that the quantile specified by Q1 is 0 and Q2 is 1. This option uses
%   the quantile function to determine these minumum and maximum values
%
%   norm = normalize_image(I,'quantiles',[Q1,Q2],'only_nonzero',1) same as
%   above, except the only values considered will be the non-zero values
%   for the determination of the proper quantiles
%
%   norm = normalize_image(I,'limits',[N1,N2]) normalizes the image so that
%   the value N1 is now 0 and the value N2 is 1
%
%   Optional Output:
%     -If a second output value is requested, it will be the limits used to
%      normalize the image
%
%   Other Functions:
%     -mat2gray: similar function available in the image processing
%      toolbox, doesn't implement the quantile or only_nonzero options
%      above


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Setup variables and parse command line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i_p = inputParser;

i_p.addRequired('image',@isnumeric);

i_p.addParameter('quantiles',@isnumeric);
i_p.addParameter('only_nonzero',@islogical);
i_p.addParameter('limits',@isnumeric);

i_p.addParameter('debug',0,@(x)(isnumeric(x) && (x == 0 || x == 1) || islogical(x)));

i_p.parse(image,varargin{:});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Main Program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

image = double(image);

if (not(any(strcmp(i_p.UsingDefaults,'quantiles'))))
    if (not(any(strcmp(i_p.UsingDefaults,'only_nonzero'))))
        limits = quantile(nonzeros(image(:)),i_p.Results.quantiles);
    else
        limits = quantile(image(:),i_p.Results.quantiles);
    end
elseif (not(any(strcmp(i_p.UsingDefaults,'limits'))))
    limits = i_p.Results.limits;
else
    limits = [min(image(:)),max(image(:))];
end

varargout{1} = limits;

image = (image - limits(1))/range(limits);

image(image > 1) = 1;
image(image < 0) = 0;
