function imwrite_with_folder_creation(image,file_target)

[output_folder, ~, ~] = fileparts(file_target);
mkdir_no_err(output_folder);
imwrite(image,file_target);

end