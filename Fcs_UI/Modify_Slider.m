function Modify_Slider(hObject, h_edit_text, par_name, ~)
    global VSAS_main
    idx = strcmp(VSAS_main.FIT_INFO.var_names, par_name);
    current_value = round((get(hObject, 'Value')), 2);
    set(h_edit_text, 'String', num2str(current_value));
    VSAS_main.var_values(idx) = current_value;
    VSAS_main.plotFitValue();
end