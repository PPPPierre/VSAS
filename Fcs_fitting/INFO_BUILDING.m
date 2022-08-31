function [INFO] = INFO_BUILDING(data, E_noramal, E_standard, par_range_table, model_table, E_stand_info, BO_Opts, GS_Opts)

    INFO = table();

    %% 创建优化用参数范围与参数名
    
    switch model_table.form_type
        case 'Sphere'
            [ParRange, weight_reg, VarNames, I_Principle_Func] = INFO_BUILDING_Sphere(par_range_table, model_table);
            
        case 'CoreShell'
            [ParRange, weight_reg, VarNames, I_Principle_Func] = INFO_BUILDING_CoreShell(par_range_table, model_table);
            
        case 'Ellipsoid'
            [ParRange, weight_reg, VarNames, I_Principle_Func] = INFO_BUILDING_Ellipsoid(par_range_table, model_table);

        otherwise
            ERROR_BOX('Check form type name.')
    end
    
    ParRange   = [ParRange par_range_table.C_range];
    weight_reg = [weight_reg, 1];
    VarNames   = [VarNames, 'C'];
    
    switch model_table.fit_alpha
        case 'Yes'
            ParRange   = [ParRange par_range_table.alpha_range];
            weight_reg = [weight_reg, 1];
            VarNames   = [VarNames, 'alpha'];
        case 'No'  
    end
    
    ParRange   = [ParRange par_range_table.Ibg_range];
    weight_reg = [weight_reg, 1];
    VarNames   = [VarNames, 'Ibg'];
    
    ParNum        = size(ParRange,2);
    ParRange_Norm = cell(1,ParNum);
    min_list      = zeros(1,ParNum);
    max_list      = zeros(1,ParNum);
    min_list_norm = zeros(1,ParNum);
    max_list_norm = ones(1,ParNum);
    
    for i = 1:ParNum
        range = ParRange(i);
        min_list(1,i)      = range{1}(1);
        max_list(1,i)      = range{1}(2);
        ParRange_Norm{i} = [0,1];
    end
    ParRangeArray      = {[min_list;max_list]};
    ParRangeArray_Norm = {[min_list_norm;max_list_norm]};

    %% Choose fit model function 选择拟合函数
        INFO.I_Principle_Func = I_Principle_Func;
    
    %% Parameters
        INFO.ParNum             = ParNum;
        INFO.ParRange           = ParRange;
        INFO.ParRange_Norm      = ParRange_Norm;
        INFO.ParRangeArray      = ParRangeArray;
        INFO.ParRangeArray_Norm = ParRangeArray_Norm;
        INFO.VarNames           = VarNames;
        INFO.Log_VarNames       = ['C', 'Ibg', 'fV1', 'fV2'];

    %% Regulation
        INFO.lam_reg    = model_table.lam_reg;
        INFO.weight_reg = weight_reg;
        INFO.lam_sigma  = model_table.lam_sigma;

    %% Data
        switch model_table.sld_input
           case 'Yes'
               INFO.rho = model_table.rho;
           case 'No'
        end
        switch model_table.fit_alpha
           case 'Yes'
           case 'No'
               INFO.alpha = model_table.alpha;
        end
        INFO.Q         = (data(:,1))'; 
        INFO.Data_size = size(INFO.Q, 2);
        INFO.E         = (data(:, 2))';
        INFO.E_normal  = (E_noramal)';
        INFO.E_stand   = (E_standard)';

    %% Model
        INFO.form_type = model_table.form_type;
        INFO.dis_type  = model_table.distribution_type;
        INFO.dis_mode  = model_table.distribution_mode;
        INFO.mat_type  = model_table.material_type;
        INFO.sld_input = model_table.sld_input;
        INFO.fit_alpha = model_table.fit_alpha;
        
    %% Standardization
        INFO.E_mean = E_stand_info.mean;
        INFO.E_std  = E_stand_info.std;

    %% Options for Baysian Optimization
        INFO.Bayes_MaxObjectiveEvaluations  = BO_Opts.MaxObjectiveEvaluations;
        INFO.Bayes_AcquisitionFunctionName  = BO_Opts.AcquisitionFunctionName;
        INFO.Bayes_NumSeedPoints            = BO_Opts.NumSeedPoints;
        INFO.Bayes_ExplorationRatio         = BO_Opts.ExplorationRatio;
        INFO.Bayes_IsObjectiveDeterministic = BO_Opts.IsObjectiveDeterministic;
        
    %% Options for Grid Search
        INFO.GS_point_range  = GS_Opts.point_range;
        INFO.GS_point_number = GS_Opts.point_number;
        INFO.GS_search_mode  = GS_Opts.search_mode;
end
