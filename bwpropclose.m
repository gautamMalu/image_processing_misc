function filtered_image = bwpropclose(bw_image,prop_name,max_val)

bw_label = bwlabel(bw_image);
props = regionprops(bw_label,prop_name);

filtered_image = ismember(bw_label,find([props.(prop_name)] <= max_val));

end