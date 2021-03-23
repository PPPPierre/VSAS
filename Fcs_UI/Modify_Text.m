function Modify_Text(hObject, h_slider, par_name, ~)
    global VSAS_main
    idx = strcmp(VSAS_main.FIT_INFO.var_names, par_name);
    current_value = str2double(get(hObject, 'String'));
    if current_value < VSAS_main.FIT_INFO.var_range{idx}(1)
        current_value = VSAS_main.FIT_INFO.var_range{idx}(1);
        Error_Out_Of_Range();
    elseif current_value > VSAS_main.FIT_INFO.var_range{idx}(2)
        current_value = VSAS_main.FIT_INFO.var_range{idx}(2);
        Error_Out_Of_Range();
    end
    VSAS_main.var_values(idx) = current_value;
    set(h_slider, 'Value', current_value);
    VSAS_main.plotFitValue();
end