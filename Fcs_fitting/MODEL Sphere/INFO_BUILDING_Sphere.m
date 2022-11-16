function model_info = INFO_BUILDING_Sphere(par_range_table, model_table, symbol_table)  
    
    VarSymbols = { symbol_table.Rm };
    ParRange   = { par_range_table.Rm_range };
    weight_reg = [1, 2];                                                    % 正则化系数
    VarNames   = { 'Rm1' };
    
    switch [model_table.distribution_mode, ' ', model_table.sld_input]
        case 'MonoDispersed Yes'
            VarSymbols = [VarSymbols ...
                          symbol_table.fV];
            ParRange   = [ParRange ...
                          par_range_table.fV_range];
            VarNames   = [VarNames,'fV1'];
            I_Priciple = @I_Sphere_MonoDispersed;
            
        case 'MonoDispersed No'
            VarSymbols = [VarSymbols ...
                          symbol_table.fVrho2];
            ParRange   = [ParRange ...
                          par_range_table.fVrho2_range];
            VarNames   = [VarNames,'fV1rho2'];
            I_Priciple = @I_Sphere_MonoDispersed_NoSLD;

        case 'Single Yes'
            VarSymbols = [VarSymbols ...
                          symbol_table.sigma];
            ParRange   = [ParRange ...
                          par_range_table.sigma_range];
            weight_reg = [weight_reg, 2];                                  % 正则化系数
            VarNames   = [VarNames, 'sigma1'];
            VarSymbols = [VarSymbols ...
                          symbol_table.fV];
            ParRange   = [ParRange ...
                          par_range_table.fV_range];
            VarNames   = [VarNames,'fV1'];
            I_Priciple = @I_Sphere_Single;
            
        case 'Single No'
            VarSymbols = [VarSymbols ...
                          symbol_table.sigma];
            ParRange   = [ParRange ...
                          par_range_table.sigma_range];
            weight_reg = [weight_reg, 2];                                  % 正则化系数
            VarNames   = [VarNames, 'sigma1'];
            VarSymbols = [VarSymbols ...
                          symbol_table.fVrho2];
            ParRange   = [ParRange ...
                          par_range_table.fVrho2_range];
            VarNames   = [VarNames,'fV1rho2'];
            I_Priciple = @I_Sphere_Single_NoSLD;
            
        case 'Double Yes'
            VarSymbols = [VarSymbols ...
                          symbol_table.sigma];
            ParRange   = [ParRange ...
                          par_range_table.sigma_range];
            weight_reg = [weight_reg, 2];                                  % 正则化系数
            VarNames   = [VarNames, 'sigma1'];
            VarSymbols = [VarSymbols ...
                          symbol_table.fV];
            ParRange   = [ParRange ...
                          par_range_table.fV_range];
            VarNames   = [VarNames,'fV1'];
            VarSymbols = [VarSymbols ...
                          symbol_table.Rm2 ...
                          symbol_table.sigma2];
            ParRange   = [ParRange ...
                          par_range_table.Rm2_range ...
                          par_range_table.sigma2_range];
            weight_reg = [weight_reg, 2, 2];
            VarNames   = [VarNames, 'Rm2', 'sigma2'];
            VarSymbols = [VarSymbols ...
                          symbol_table.fV2];
            ParRange   = [ParRange ...
                          par_range_table.fV2_range];
            weight_reg = [weight_reg, 1];
            VarNames   = [VarNames, 'fV2'];
            I_Priciple = @I_Sphere_Double;
            
        case 'Double No'
            VarSymbols = [VarSymbols ...
                          symbol_table.sigma];
            ParRange   = [ParRange ...
                          par_range_table.sigma_range];
            weight_reg = [weight_reg, 2];                                  % 正则化系数
            VarNames   = [VarNames, 'sigma1'];
            VarSymbols = [VarSymbols ...
                          symbol_table.fVrho2];
            ParRange = [ParRange ...
                        par_range_table.fVrho2_range];
            VarNames = [VarNames,'fV1rho2'];
            VarSymbols = [VarSymbols ...
                          symbol_table.Rm2 ...
                          symbol_table.sigma2];
            ParRange   = [ParRange ...
                          par_range_table.Rm2_range ...
                          par_range_table.sigma2_range];
            weight_reg = [weight_reg, 2, 2];
            VarNames   = [VarNames, 'Rm2', 'sigma2'];
            VarSymbols = [VarSymbols ...
                          symbol_table.fV2rho2];
            ParRange   = [ParRange ...
                          par_range_table.fV2rho2_range];
            weight_reg = [weight_reg, 1];
            VarNames   = [VarNames, 'fV2rho2'];
            I_Priciple = @I_Sphere_Double_NoSLD;
                    
        otherwise
            ERROR_BOX('Check distribution mode name.')
    end
    model_info = table();
    model_info.var_range = ParRange;
    model_info.weight_reg = weight_reg;
    model_info.var_names = VarNames;
    model_info.var_symbols = VarSymbols;
    model_info.I_principle_func = I_Priciple;
end