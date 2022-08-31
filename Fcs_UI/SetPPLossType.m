function SetPPLossType(hObject, ~)

    global VSAS_main
    current_value = get(hObject, 'Value');
    switch current_value
        case 1
            set_string = 'Chi2';
        case 2
            set_string = 'MSE';
    end
    VSAS_main.set_program_par_table.loss_type = set_string;
    
end