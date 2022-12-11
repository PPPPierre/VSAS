function SetRhoOrderCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.FIT_INFO.model_table.rho_order = current_value;
    
    new_rho   = VSAS_main.FIT_INFO.model_table.rho_unit * 10^(current_value);
    VSAS_main.FIT_INFO.model_table.rho = new_rho / 10^(14-3.5);
    
    if VSAS_main.flag_fit_slider_init == 1
        VSAS_main = VSAS_main.buildVarINFO();
        VSAS_main = VSAS_main.initVarSliders();
    end
end