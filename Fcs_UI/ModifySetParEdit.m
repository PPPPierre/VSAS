function ModifySetParEdit(hObject, idx_var, idx_extern, ~)
    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.FIT_INFO.var_range_table{1, idx_var}(idx_extern) = current_value;
    if VSAS_main.flag_fit_slider_init == 1
        VSAS_main = VSAS_main.buildVarINFO();
        VSAS_main = VSAS_main.initVarSliders();
    end
end