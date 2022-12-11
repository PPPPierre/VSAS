function SetBONumObjEvaCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.FIT_INFO.BO_opt_table.MaxObjectiveEvaluations = current_value;
    
end