function SetGSModeCallback(hObject, ~)

    global VSAS_main
    current_value = get(hObject, 'Value');
    switch current_value
        case 1
            set_string = 'Random';
        case 2
            set_string = 'No Random';
    end
    VSAS_main.FIT_INFO.GS_opt_table.search_mode = set_string;
    
end