function SetGSRangCallback(hObject, ~)

    global VSAS_main
    current_value = str2double(get(hObject, 'String'));
    VSAS_main.set_GS_opt_table.point_range = current_value;
    
end