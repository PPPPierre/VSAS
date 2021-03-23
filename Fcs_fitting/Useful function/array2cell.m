function my_cell = array2cell(my_array)
    num_array  = numel(my_array);
    my_cell    = cell(size(my_array));
    for i = 1 : num_array
        my_cell{i} = my_array(i);
    end
end