function imwrite_with_folder_creation(image,file_target)
%IMWRITE_WITH_FOLDER_CREATION    output a given image to target, with
%creation of the folder
%
%   imwrite_with_folder_creation(I,FILE) outputs image, I, to file, FILE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Setup variables and parse command line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_p = inputParser;
i_p.FunctionName = 'IMWRITE_WITH_FOLDER_CREATION';

i_p.addRequired('image',@(x)isnumeric(x) || islogical(x));
i_p.addRequired('file_target',@(x)(ischar(x)));

i_p.parse(image,file_target);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Main Program
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[output_folder, ~, ~] = fileparts(file_target);
mkdir_no_err(output_folder);
imwrite(image,file_target);

end