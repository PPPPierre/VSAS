function SetPPCheckLimCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.set_program_par_table.check_limit = current_value;
    
end