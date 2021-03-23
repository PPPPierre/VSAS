function SetSaveButtonCallback(~, ~)
    global VSAS_main
    new_var_range_table = cell2table(VSAS_main.set_par_range_cell, ...
                                     'VariableNames', VSAS_main.FIT_INFO.var_range_names_cell);
    new_model_table       = VSAS_main.set_model_table;
    new_model_table.rho   = new_model_table.rho_unit * 10^(new_model_table.rho_order) / 10^(14-3.5);
    new_BO_opt_table      = VSAS_main.set_BO_opt_table;
    new_GS_opt_table      = VSAS_main.set_GS_opt_table;
    new_program_par_table = VSAS_main.set_program_par_table;
    
    VSAS_main.FIT_INFO.var_range_table   = new_var_range_table;
    VSAS_main.FIT_INFO.model_table       = new_model_table;
    VSAS_main.FIT_INFO.BO_opt_table      = new_BO_opt_table;
    VSAS_main.FIT_INFO.GS_opt_table      = new_GS_opt_table;
    VSAS_main.FIT_INFO.program_par_table = new_program_par_table;
    
    if VSAS_main.flag_fit_slider_init == 1
        VSAS_main = VSAS_main.buildVarINFO();
        VSAS_main = VSAS_main.initVarSliders();
    end
    
    close(VSAS_main.wd_set_figure);
end