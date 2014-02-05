function filtered_image = bwpropopen(bw_image,prop_name,min_val)

bw_label = bwlabel(bw_image);
props = regionprops(bw_label,prop_name);

filtered_image = ismember(bw_label,find([props.(prop_name)] >= min_val));

end