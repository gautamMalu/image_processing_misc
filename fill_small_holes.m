function filled_image = fill_small_holes(binary_image,max_hole_size)
    filled_holes = imfill(binary_image,'holes') & not(binary_image);
    
    small_holes = bwpropclose(filled_holes,'Area',max_hole_size);
    
    filled_image = binary_image | small_holes;
end