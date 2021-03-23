function var_range = GET_VAR_RANGE(data_array, var_names_list, var_name)

    idx = strcmp(var_names_list, var_name);
    var_range = data_array(idx, :);
    
end