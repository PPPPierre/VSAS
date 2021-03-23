function SetMatTypeCallback(hObject, ~)

    global VSAS_main
    current_value = get(hObject, 'Value');
    switch current_value
        case 1
            set_string = 'ASZ';
        case 2
            set_string = 'AlScZr_SANS_Linear';
        case 3
            set_string = 'AlScZr_SAXS_Linear';
    end
    VSAS_main.set_model_table.material_type = set_string;
    
end