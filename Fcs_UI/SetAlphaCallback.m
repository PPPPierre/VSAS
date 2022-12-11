function SetAlphaCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.FIT_INFO.model_table.alpha = current_value;
    
    if VSAS_main.flag_fit_slider_init == 1
        VSAS_main = VSAS_main.buildVarINFO();
        VSAS_main = VSAS_main.initVarSliders();
    end
end