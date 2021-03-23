function SetRhoOrderCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.set_model_table.rho_order = current_value;
    
end