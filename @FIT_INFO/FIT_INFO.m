classdef FIT_INFO
    properties
        
        INFO;
        flag;
        
        model_table;
        var_names_cell;
        var_range_table;
        var_range_names_cell;
        var_symbol_table;
        BO_opt_table;
        GD_opt_table;
        GS_opt_table;
        program_par_table;
        
        var_range;
        weight_reg;
        var_names;
        var_symbols;
        I_principle_func;
        
    end
    
    methods
        function item = FIT_INFO()
            item.INFO = table();
            item.flag = 0;
            item.model_table       = table();
            item.var_range_table   = table();
            item.var_symbol_table  = table();
            item.BO_opt_table      = table();
            item.GD_opt_table      = table();
            item.GS_opt_table      = table();
            item.program_par_table = table();
            item = item.buildVarRangeTable();
            item = item.buildVarSymbolTable();
            item = item.buidFitParTable();
            item = item.buildVarNamesCell();
        end
        
        function obj = buildVarNamesCell(obj)
            obj.var_names_cell = {'C', ...
                                  'alpha', ...
                                  'Ibg', ...
                                  'fV', ...
                                  'Rm', ...
                                  'sigma', ...
                                  'fV2', ...
                                  'Rm2', ...
                                  'sigma2', ...
                                  'nu', ...
                                  'x', ...
                                  'k', ...
                                  'fVrho2', ...
                                  'fV2rho2'};
            obj.var_range_names_cell = {'C_range', ...
                                        'alpha_range', ...
                                        'Ibg_range', ...
                                        'fV_range', ...
                                        'Rm_range', ...
                                        'sigma_range', ...
                                        'fV2_range', ...
                                        'Rm2_range', ...
                                        'sigma2_range', ...
                                        'nu_range', ...
                                        'x_range', ...
                                        'k_range', ...
                                        'fVrho2_range', ...
                                        'fV2rho2_range'};
        end
        
        function obj = buildVarRangeTable(obj)
            obj.var_range_table.C_range       = [-6, 0];
            obj.var_range_table.alpha_range   = [3, 4];
            obj.var_range_table.Ibg_range     = [-6, 0];
            
            obj.var_range_table.fV_range      = [-11, -2];
            obj.var_range_table.Rm_range      = [0.3, 20];
            obj.var_range_table.sigma_range   = [0.01, 1];
            
            obj.var_range_table.fV2_range     = [-11, -2];
            obj.var_range_table.Rm2_range     = [0.3, 20];
            obj.var_range_table.sigma2_range  = [0.01, 1];
            obj.var_range_table.nu_range      = [0.5, 1];
            obj.var_range_table.x_range       = [0, 1];
            obj.var_range_table.k_range       = [0.5, 3];
            obj.var_range_table.fVrho2_range  = [-9, -4];
            obj.var_range_table.fV2rho2_range = [-9, -4];
        end
        
        function obj = buildVarSymbolTable(obj)
            obj.var_symbol_table.C       = '$\log C$';
            obj.var_symbol_table.alpha   = '$\alpha$';
            obj.var_symbol_table.Ibg     = '$\log I_{bg}$';
            obj.var_symbol_table.fV      = '$\log f_V$';
            obj.var_symbol_table.Rm      = '$R_m$';
%             obj.var_symbol_table.sigma   = '$\frac{\sigma}{|\log{R_m}|}$';
            obj.var_symbol_table.sigma   = '$\sigma$';
            obj.var_symbol_table.fV2     = '$\log f_{V_2}$';
            obj.var_symbol_table.Rm2     = '$R_{m2}$';
%             obj.var_symbol_table.sigma2  = '$\frac{\sigma_2}{|\log{R_{m2}}|}$';
            obj.var_symbol_table.sigma2   = '$\sigma_2$';
            obj.var_symbol_table.nu      = '$\nu$';
            obj.var_symbol_table.x       = '$x$';
            obj.var_symbol_table.k       = '$k$';
            obj.var_symbol_table.fVrho2  = '$\log(f_{V}\Delta\rho^2)$';
            obj.var_symbol_table.fV2rho2 = '$\log(f_{V_2}\Delta\rho^2)$';
        end
        
        function obj = buidFitParTable(obj)
            obj.model_table.material_type             = 'AlScZr_SANS_Linear';        % ASZ = ����� Only for CoreShell
            obj.model_table.rho_unit                  = 1.2;
            obj.model_table.rho_order                 = 10;
            obj.model_table.rho                       = obj.model_table.rho_unit * 10^(obj.model_table.rho_order) / 10^(14-3.5);
            obj.model_table.alpha                     = 4;
            obj.BO_opt_table.MaxObjectiveEvaluations  = 40;                         % ����������  10�� 20 ��30 ��40 ��50
            obj.BO_opt_table.AcquisitionFunctionName  = 'expected-improvement-plus'; % ����������    'expected-improvement', 'lower-confidence-bound'
            obj.BO_opt_table.NumSeedPoints            = 6000;                        % ��ʼ���ӵ���
            obj.BO_opt_table.ExplorationRatio         = 0.4;                         % ����ϵ����    0.2, 0.4, 0.5, 0.6, 0.8 
            obj.BO_opt_table.IsObjectiveDeterministic = true;                        % Ĭ�ϡ�True��
        % Options of Gradient Descent
        % Options of Grid Search
            obj.GS_opt_table.point_range  = 100;                                     % ������Χ �� 5 ��Ӧ��һ���������Χ�� +- 0.005 
            obj.GS_opt_table.point_number = 50;                                      % �����ѡȡ����
            obj.GS_opt_table.search_mode  = 'Random';                                % ����Ҫ��������ģʽ 'No Random'
        % Program parameters
            obj.program_par_table.fit_times  = 5;
            obj.program_par_table.stop_loss  = 10;
            obj.program_par_table.check_limit = 0;
            obj.program_par_table.plot_num    = 1;
            obj.program_par_table.loss_type = 'Chi2';
        end
        
        function obj = buildVarInfo(obj, data, mode_dist, mode_form, mode_stru, mode_sld, mode_alpha)
            
            obj.flag = 1;
            
            switch mode_dist
                case '2'
                    obj.model_table.distribution_mode = 'MonoDispersed';
                case '3'
                    obj.model_table.distribution_mode = 'Single';
                case '4'
                    obj.model_table.distribution_mode = 'Double';
            end

            switch mode_form
                case '2'
                    obj.model_table.form_type = 'Sphere';
                case '3'
                    obj.model_table.form_type = 'Ellipsoid';
                case '4'
                    obj.model_table.form_type = 'CoreShell';
            end
            
            obj.model_table.distribution_type = 'LogNormal';
            
            switch mode_sld
                case '2'
                    obj.model_table.sld_input = 'Yes';
                case '3'
                    obj.model_table.sld_input = 'No';
            end
            
            switch mode_alpha
                case '2'
                    obj.model_table.fit_alpha = 'Yes';
                case '3'
                    obj.model_table.fit_alpha = 'No';
            end
            
            obj.model_table.lam_reg   = 0.5;
            obj.model_table.lam_sigma = 1;
           % �����Ż��ò�����Χ�������
                
            switch obj.model_table.form_type
                case 'Sphere'
                    model_info = INFO_BUILDING_Sphere(obj.var_range_table, obj.model_table, obj.var_symbol_table);
                    obj.var_range = model_info.var_range;
                    obj.weight_reg = model_info.weight_reg;
                    obj.var_names = model_info.var_names;
                    obj.var_symbols = model_info.var_symbols;
                    obj.I_principle_func = model_info.I_principle_func;
                    q = reshape(obj.INFO.Q, length(obj.INFO.Q), 1);
                    obj.INFO.R = obj.INFO.size_space;
                    obj.INFO.V = VOLUME_Sphere(obj.INFO.R);
                    obj.INFO.i = {INT_SINGLE_Sphere(q, obj.INFO.R)};

                case 'CoreShell'
                    [obj.var_range, obj.weight_reg, obj.var_names, obj.var_symbols, obj.I_principle_func] = INFO_BUILDING_CoreShell(obj.var_range_table, obj.model_table, obj.var_symbol_table);

                case 'Ellipsoid'
                    [obj.var_range, obj.weight_reg, obj.var_names, obj.var_symbols, obj.I_principle_func] = INFO_BUILDING_Ellipsoid(obj.var_range_table, obj.model_table, obj.var_symbol_table);

                otherwise
                    ERROR_BOX('Check form type name.')
            end
            
            obj.var_symbols = [obj.var_symbols obj.var_symbol_table.C];
            obj.var_range   = [obj.var_range obj.var_range_table.C_range];
            obj.weight_reg  = [obj.weight_reg, 1];
            obj.var_names   = [obj.var_names, 'C'];
            
            switch obj.model_table.fit_alpha
                case 'Yes'
                    obj.var_symbols = [obj.var_symbols obj.var_symbol_table.alpha];
                    obj.var_range   = [obj.var_range obj.var_range_table.alpha_range];
                    obj.weight_reg  = [obj.weight_reg, 1];
                    obj.var_names   = [obj.var_names, 'alpha'];
                case 'No'  
            end
            
            obj.var_symbols = [obj.var_symbols obj.var_symbol_table.Ibg];
            obj.var_range   = [obj.var_range obj.var_range_table.Ibg_range];
            obj.weight_reg  = [obj.weight_reg, 1];
            obj.var_names   = [obj.var_names, 'Ibg'];
            

            ParNum        = size(obj.var_range,2);
            ParRange_Norm = cell(1,ParNum);
            min_list      = zeros(1,ParNum);
            max_list      = zeros(1,ParNum);
            min_list_norm = zeros(1,ParNum);
            max_list_norm = ones(1,ParNum);

            for i = 1:ParNum
                range = obj.var_range(i);
                min_list(1,i)      = range{1}(1);
                max_list(1,i)      = range{1}(2);
                ParRange_Norm{i} = [0,1];
            end
            ParRangeArray      = {[min_list;max_list]};
            ParRangeArray_Norm = {[min_list_norm;max_list_norm]};

            % Choose fit model function ѡ����Ϻ���
                obj.INFO.I_Principle_Func = obj.I_principle_func;

            % Parameters
                obj.INFO.ParNum             = ParNum;
                obj.INFO.ParRange           = obj.var_range;
                obj.INFO.ParRange_Norm      = ParRange_Norm;
                obj.INFO.ParRangeArray      = ParRangeArray;
                obj.INFO.ParRangeArray_Norm = ParRangeArray_Norm;
                obj.INFO.VarNames           = obj.var_names;
                obj.INFO.Log_VarNames = [
                    'C', 'Ibg', ...
                    'fV1', 'fV2', ...
                    'fV1rho2', 'fV2rho2'
                    ];

            % Regulation
                obj.INFO.lam_reg    = obj.model_table.lam_reg;
                obj.INFO.weight_reg = obj.weight_reg;
                obj.INFO.lam_sigma  = obj.model_table.lam_sigma;

            % Data
                switch obj.model_table.sld_input
                   case 'Yes'
                       obj.INFO.rho      = obj.model_table.rho;
                   case 'No'
                end
                switch obj.model_table.fit_alpha
                   case 'Yes'
                   case 'No'
                       obj.INFO.alpha = obj.model_table.alpha;
                end
                
            %% Model
                obj.INFO.form_type = obj.model_table.form_type;
                obj.INFO.dis_type  = obj.model_table.distribution_type;
                obj.INFO.dis_mode  = obj.model_table.distribution_mode;
                obj.INFO.mat_type  = obj.model_table.material_type;
                obj.INFO.sld_input = obj.model_table.sld_input;
                obj.INFO.fit_alpha = obj.model_table.fit_alpha;
                obj.INFO.material = obj.loadMaterialFile();

            %% Options for Baysian Optimization
                obj.INFO.Bayes_MaxObjectiveEvaluations  = obj.BO_opt_table.MaxObjectiveEvaluations;
                obj.INFO.Bayes_AcquisitionFunctionName  = obj.BO_opt_table.AcquisitionFunctionName;
                obj.INFO.Bayes_NumSeedPoints            = obj.BO_opt_table.NumSeedPoints;
                obj.INFO.Bayes_ExplorationRatio         = obj.BO_opt_table.ExplorationRatio;
                obj.INFO.Bayes_IsObjectiveDeterministic = obj.BO_opt_table.IsObjectiveDeterministic;

            %% Options for Grid Search
                obj.INFO.GS_point_range  = obj.GS_opt_table.point_range;
                obj.INFO.GS_point_number = obj.GS_opt_table.point_number;
                obj.INFO.GS_search_mode  = obj.GS_opt_table.search_mode;
        end
        
        function obj = loadData(obj, data)
            obj.INFO.Q = (data(:,1))';
            obj.INFO.E = (data(:,2))';
            obj.INFO.E_log = log(data(:,2))';
            obj.INFO.dE = (data(:, 3))';
            obj.INFO.dE_log = (1/data(:,2)*data(:,3))';
            obj.INFO.dt_detect_scale_min = 1/max(obj.INFO.Q);
            obj.INFO.dt_detect_scale_max = max(1/min(obj.INFO.Q), 1/mean(diff(obj.INFO.Q)));
            obj.INFO.Data_size = size(obj.INFO.Q, 2);
            obj.INFO.step = 1000;
            obj.INFO.size_space = linspace(obj.INFO.dt_detect_scale_min, obj.INFO.dt_detect_scale_max, obj.INFO.step);
            obj.var_range_table.Rm_range = [obj.INFO.dt_detect_scale_min, obj.INFO.dt_detect_scale_max];
            obj.var_range_table.Rm2_range = [obj.INFO.dt_detect_scale_min, obj.INFO.dt_detect_scale_max];
        end
        
        function material_property = loadMaterialFile(obj)
            mat = load(obj.INFO.mat_type);
            material_property = getfield(mat,obj.INFO.mat_type);
            material_property = material_property(:,2)';
        end
        
        
    end

end