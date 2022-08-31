function SetBONumSeedCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.set_BO_opt_table.NumSeedPoints = current_value;
    
end