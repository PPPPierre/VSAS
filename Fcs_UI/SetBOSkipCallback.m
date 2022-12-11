function SetBOSkipCallback(hObject, ~)

    global VSAS_main
    current_value = get(hObject, 'value');
    VSAS_main.FIT_INFO.BO_opt_table.SkipBO = current_value;
    
end