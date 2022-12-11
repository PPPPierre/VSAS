function SetPPThreLossCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.FIT_INFO.program_par_table.stop_loss = current_value;
    
end