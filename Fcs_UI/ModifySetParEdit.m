function ModifySetParEdit(hObject, idx_var, idx_extern, ~)
    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.set_par_range_cell{idx_var}(idx_extern) = current_value;
end