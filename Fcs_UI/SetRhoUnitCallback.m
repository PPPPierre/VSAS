function SetRhoUnitCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.FIT_INFO.model_table.rho_unit = current_value;
    new_rho = current_value * 10^(VSAS_main.model_table.rho_order);
    VSAS_main.FIT_INFO.model_table.rho = new_rho / 10^(14-3.5); % Unit conversion
end