function startAutoFitting()

% 1. delta rho 
% 2. Unit of q: nm-1 [1e-3, 10]
% 4. I(q)
% 5. All logarithm are based on e

%% INITIALIZATION OF GLOBAL VARIABLES
    global VSAS_main
    global Material;
    INFO = VSAS_main.FIT_INFO.INFO;

% LOAD SERIE OF EXPERIMENTAL DATA
    FileName  = VSAS_main.file_name;
    PathName  = VSAS_main.file_path;
    
% RECORD TIME
    time_text = datestr(now,30);
    
% INITIALIZATION OF FINAL REPORT
    Final_report = table();
    result_table = table();

% START PROGRAMME ��ʼ���� 

    SampleName = FileName;

% PRETREATMENT OF EXPERIMENTAL  DATA ʵ������Ԥ����
    data = VSAS_main.dt_E_data;
    
    %
    % data(:,1) = data(:,1).*10;
    % data(:,2) = data(:,2)./96*10000;
    
    % INFO.E should always be Log result
    INFO.I_exp = INFO.E;
    INFO.I_exp_log = INFO.E;
    INFO.dI_exp_log = INFO.dE;
    
    %
    % data = REDUCE_DATA(data, 2);

%% SET OPIMIZATION OPTIONS
    program_par_table = VSAS_main.FIT_INFO.program_par_table;
    fit_times   = program_par_table.fit_times;
    % stop_loss   = program_par_table.stop_loss;
    check_limit = program_par_table.check_limit;
    plot_num    = program_par_table.plot_num;
        
%% SET LOSS FUNCTIONS
    if (strcmp(program_par_table.loss_type, 'Chi2'))
        Loss_fun_base = @LOSS_Chi2;
    elseif (strcmp(program_par_table.loss_type, 'MSE'))
        Loss_fun_base = @LOSS_MSE;
    end
    
    Loss_fun_CorMap = @LOSS_CorMap;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% START TIMING
    t = tic();

%% BUIDING INFO
    Mat = load(VSAS_main.FIT_INFO.model_table.material_type);
    Material = getfield(Mat,VSAS_main.FIT_INFO.model_table.material_type);
    P_Value_Table = load('P_Value_Table');
    P_Value_Table = getfield(P_Value_Table,'P_Value_Table');
    INFO.P_Value_Table = {P_Value_Table};
    
%% INITIALIZATION OF THE ALGORITHM �Ż������ʼ��
    X0      = array2table(zeros(fit_times,INFO.ParNum), ...
                          'VariableNames', INFO.VarNames);
    XF      = array2table(zeros(fit_times,INFO.ParNum), ...
                          'VariableNames', INFO.VarNames);
    XB      = array2table(zeros(fit_times,INFO.ParNum), ...
                          'VariableNames', INFO.VarNames);
    CorM_X0      = zeros(1,fit_times);
    Chi2_X0      = zeros(1,fit_times);
    MSE_X0       = zeros(1,fit_times);
    
    MSE_XF       = zeros(1,fit_times);
    Chi2_XF      = zeros(1,fit_times);
    CorM_XF      = zeros(1,fit_times);
    
    MSE_XB       = zeros(1,fit_times);
    Chi2_XB      = zeros(1,fit_times);
    CorM_XB      = zeros(1,fit_times);
    Max_Patch_XB = zeros(1,fit_times);
    P_Value_XB   = zeros(1,fit_times);
    Result       = zeros(fit_times, INFO.ParNum + 1);
    print_color        = [1, 0.5, 0];

%% START OPTIMIZATION
    if VSAS_main.FIT_INFO.BO_opt_table.SkipBO == 1
        start_value = VSAS_main.var_values;
        fit_times = 1;
    end

    for i = 1:fit_times
        check_times = 1;
        tim_total   = Cal_process_start('Current cycle is:', i, fit_times);

%%%%%%% Baysian Optimization
        if VSAS_main.FIT_INFO.BO_opt_table.SkipBO == 1
            x0 = array2table(start_value, 'VariableNames', VSAS_main.FIT_INFO.var_names);
        else 
            BO_result = BAYSIAN_OPTIMIZATION(INFO, @LOSS_MSE);
            x0 = BO_result.XAtMinObjective;                       % The parameters at min point
        end
        
        X0(i,:)      = x0;
        CorM_X0(1,i) = LOSS_VALUE(x0, INFO, Loss_fun_CorMap); 
        Chi2_X0(1,i) = LOSS_VALUE(x0, INFO, @LOSS_Chi2);
        MSE_X0(1,i)  = LOSS_VALUE(x0, INFO, @LOSS_MSE);

        drawnow();

        if (VSAS_main.flag_fit == 1) && (ishandle(VSAS_main.wd_waitbar))
            VSAS_main = VSAS_main.fitProceed();
        else
            VSAS_main = VSAS_main.stopFittingProgram();
            return
        end

%%%%%%% Gradient Descent
        tim_f        = Cal_process_start('Gradient Descent:', i, fit_times);
        x_fmincon    = FMINCON(x0, INFO, @LOSS_MSE);
        XF(i,:)      = x_fmincon;
        MSE_XF(1,i)  = LOSS_VALUE(x_fmincon, INFO, @LOSS_MSE);
        CorM_XF(1,i) = LOSS_VALUE(x_fmincon, INFO, Loss_fun_CorMap);
        Chi2_XF(1,i) = LOSS_VALUE(x_fmincon, INFO, @LOSS_Chi2); 
        Cal_process_end(tim_f);

        drawnow();
        if (VSAS_main.flag_fit == 1) && (ishandle(VSAS_main.wd_waitbar))
            VSAS_main = VSAS_main.fitProceed();
        else
            VSAS_main = VSAS_main.stopFittingProgram();
            return
        end
        cprintf(print_color, strcat('\t', 'Best result:', 32, num2str(Chi2_XF(1,i)), '\n'));

%%%%%%% Grid Search
        tim_b    = Cal_process_start('Grid Search:', i, fit_times);
        x_better = GRID_SEARCH(x_fmincon, INFO, @LOSS_Pcor);
        while(~isequal(table2array(x_fmincon), table2array(x_better)) && check_times < check_limit)
            x_fmincon   = FMINCON(x_better, INFO, @LOSS_MSE);
            x_better    = GRID_SEARCH(x_fmincon, INFO, @LOSS_Pcor);
            check_times = check_times + 1;
        end

        drawnow();
        if (VSAS_main.flag_fit == 1) && (ishandle(VSAS_main.wd_waitbar))
            VSAS_main = VSAS_main.fitProceed();
        else
            VSAS_main = VSAS_main.stopFittingProgram();
            return
        end

        XB(i,:)           = x_better;
        VB_temp           = FIT_VALUE(x_better, INFO);
        Max_Patch         = GET_MAX_PATCH(VB_temp, INFO);
        Max_Patch_XB(1,i) = Max_Patch;
        try
            P_Value_XB(1,i)   = P_Value_Table(INFO.Data_size+1 ,Max_Patch);
        catch
            P_Value_XB(1,i)   = 0;
        end
        MSE_XB(1,i)       = LOSS_VALUE(x_better, INFO, @LOSS_MSE);
        Chi2_XB(1,i)      = LOSS_VALUE(x_better, INFO, @LOSS_Chi2);
        CorM_XB(1,i)      = LOSS_VALUE(x_better, INFO, Loss_fun_CorMap);
        Loss              = LOSS_VALUE(x_better, INFO, @LOSS_MSE);
        Result(i,:)       = [table2array(x_better) Loss];
        Cal_process_end(tim_b);
        Cal_process_end(tim_total);

    end 
    CorM_history       = [CorM_X0; CorM_XF; CorM_XB];
    Chi2_history       = [Chi2_X0; Chi2_XF; Chi2_XB];
    MSE_history        = [MSE_X0; MSE_XF; MSE_XB];
    [Best_num, Output] = DATASET2OUTPUT(Result, INFO);
    var_value = XB(Best_num,:);
    % var_value = VAR_INVERSE_NORMALIZATION(XB(Best_num,:), INFO);
    VSAS_main = VSAS_main.setVarValue(table2array(var_value));

%% TOTAL TIME COST
    Total_time = round(toc(t),2);
    Mean_time  = round(Total_time / fit_times, 2);
    cprintf(print_color, strcat('Total time used:', 32, num2str(Total_time), 's\n'));
                      
%% OUTPUT TO USER
    Save_Path                 = [PathName, time_text, '\']; 
    Save_Name                 = [SampleName(1:end - 4), '-', time_text];
    report                    = OUTPUT_REPORT(Best_num, XB, MSE_history, Chi2_history, CorM_history, Max_Patch_XB, P_Value_XB, INFO);
    X_Best                    = report(Best_num,:);
    final_result              = OUTPUT_FINALREPORT(X_Best, SampleName, Total_time, Mean_time, fit_times, INFO);
    Final_report(1, :)        = final_result;
    
    result_table.X0           = {X0};
    result_table.XF           = {XF};
    result_table.XB           = {XB};
    result_table.FIT_INFO     = {VSAS_main.FIT_INFO};
    result_table.Best_num     = Best_num;
    result_table.total_time   = Total_time;
    result_table.time_text    = {time_text};
    result_table.SampleName   = {SampleName};
    result_table.PathName     = {PathName};
    result_table.report       = {report};
    result_table.X_Best       = X_Best;
    result_table.final_result = final_result;
    result_table.Final_report = Final_report;
    result_table.Save_Name    = {Save_Name};
    result_table.Save_Path    = {Save_Path};
    result_table.data = {data};
    
    VSAS_main.result_table    = result_table;
    VSAS_main = VSAS_main.fitFinish();
    
%     if exist(Save_Path, 'dir') == 0
%         mkdir(Save_Path);
%     end
%     
%     save([Save_Path,'result_table.mat'], 'result_table');
    
end
