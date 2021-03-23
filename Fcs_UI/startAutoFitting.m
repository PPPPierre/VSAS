function startAutoFitting()

% 面对新的实验数据，首先需要确认两点：
% 1. delta rho 也就是小角散射中的散射长度密度的取值，在拟合中是需要作为参数输入的，确认后需要在 {预设小角散射理论模型} 处输入；
% 2. 程序中需要将I(q)的单位换算为cm-1，q的单位换算为nm，以及I(q)需要取对数，请在下一步 {实验数据预处理} 中对其进行处理。

%% INITIALIZATION OF GLOBAL VARIABLES 声明全局变量
    global VSAS_main
    global Material;

% LOAD SERIE OF EXPERIMENTAL DATA 载入实验数据
    FileName  = VSAS_main.file_name;
    PathName  = VSAS_main.file_path;   % 设置数据存放的文件夹路径
    
% RECORD TIME 记录当前时间
    time_text = datestr(now,30);                          % 记录当前时间
    
% INITIALIZATION OF FINAL REPORT 初始化总表格
    Final_report = table();
    result_table = table();

% START PROGRAMME 开始程序 

    SampleName = FileName;

% PRETREATMENT OF EXPERIMENTAL  DATA 实验数据预处理
    data = VSAS_main.dt_E_data;
    
    % 单位换算
    data(:,1) = data(:,1).*10;                            % 对q进行单位换算
    % data(:,2) = data(:,2)./96*10000;                    % 对I(q)进行单位换算
    
    % Log处理
    data(:,2) = log(data(:,2));                           % log(I(q))
    
    % 数据规模压缩
    % data = REDUCE_DATA(data, 2);

%% SET OPIMIZATION OPTIONS 预设优化程序超参数
    program_par_table = VSAS_main.FIT_INFO.program_par_table;
    fit_times   = program_par_table.fit_times;                                                       % 总拟合次数
    stop_loss   = program_par_table.stop_loss;                                                       % 停止程序的损失函数（CorMap）界限 10 比较合理
    check_limit = program_par_table.check_limit;                                                       % GridSearch 循环次数上限
    plot_num    = program_par_table.plot_num;
        
%% SET LOSS FUNCTIONS 设置损失函数
    Loss_fun_MSE    = @LOSS_MSE;
    Loss_fun_CorMap = @LOSS_CorMap;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% START TIMING 计时开始
    t = tic();

%% BUIDING INFO 打包设定所有优化信息
    INFO = VSAS_main.FIT_INFO.INFO;
    Mat = load(VSAS_main.FIT_INFO.model_table.material_type);
    Material = getfield(Mat,VSAS_main.FIT_INFO.model_table.material_type);
    P_Value_Table = load('P_Value_Table');
    P_Value_Table = getfield(P_Value_Table,'P_Value_Table');
    
%% INITIALIZATION OF THE ALGORITHM 优化程序初始化
    X0      = array2table(zeros(fit_times,INFO.ParNum), ...
                          'VariableNames', INFO.VarNames);
    XF      = array2table(zeros(fit_times,INFO.ParNum), ...
                          'VariableNames', INFO.VarNames);
    XB      = array2table(zeros(fit_times,INFO.ParNum), ...
                          'VariableNames', INFO.VarNames);
    CorM_X0      = zeros(1,fit_times);
    Chi2_X0      = zeros(1,fit_times);
    CorM_XF      = zeros(1,fit_times);
    Chi2_XF      = zeros(1,fit_times);
    CorM_XB      = zeros(1,fit_times);
    Chi2_XB      = zeros(1,fit_times);
    Max_Patch_XB = zeros(1,fit_times);
    P_Value_XB   = zeros(1,fit_times);
    Result       = zeros(fit_times, INFO.ParNum + 1);

%% START OPTIMIZATION 开始优化
    for i = 1:fit_times
        check_times = 1;
        tim_total   = Cal_process_start('Current cycle is:', i, fit_times);

        %% Baysian Optimization
            BO_result    = BAYSIAN_OPTIMIZATION(INFO, Loss_fun_MSE);
            x0           = BO_result.XAtMinObjective;                       % The parameters at min point
            X0(i,:)      = x0;
            CorM_X0(1,i) = LOSS_VALUE(x0, INFO, Loss_fun_CorMap); 
            Chi2_X0(1,i) = LOSS_VALUE(x0, INFO, Loss_fun_MSE);
            
            drawnow();
            
             if (VSAS_main.flag_fit == 1) && (ishandle(VSAS_main.wd_waitbar))
                 VSAS_main = VSAS_main.fitProceed();
             else
                 VSAS_main = VSAS_main.stopFittingProgram();
%                 return
             end
            

        %% Gradient Descent
            tim_f        = Cal_process_start('Gradient Descent:', i, fit_times);
            x_fmincon    = FMINCON(x0, INFO, Loss_fun_MSE);
            XF(i,:)      = x_fmincon;
            CorM_XF(1,i) = LOSS_VALUE(x_fmincon, INFO, Loss_fun_CorMap);
            Chi2_XF(1,i) = LOSS_VALUE(x_fmincon, INFO, Loss_fun_MSE); 
            Cal_process_end(tim_f);
            
            drawnow();
            if (VSAS_main.flag_fit == 1) && (ishandle(VSAS_main.wd_waitbar))
                VSAS_main = VSAS_main.fitProceed();
            else
                VSAS_main = VSAS_main.stopFittingProgram();
                return
            end

        %% Grid Search
            tim_b    = Cal_process_start('Grid Search:', i, fit_times);
            x_better = GRID_SEARCH(x_fmincon, INFO, Loss_fun_CorMap);
            while(~isequal(table2array(x_fmincon), table2array(x_better)) && check_times < check_limit)
                x_fmincon   = FMINCON(x_better, INFO, Loss_fun_MSE);
                x_better    = GRID_SEARCH(x_fmincon, INFO, Loss_fun_CorMap);
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
            P_Value_XB(1,i)   = P_Value_Table(INFO.Data_size+1 ,Max_Patch);
            CorM_XB(1,i)      = LOSS_VALUE(x_better, INFO, Loss_fun_CorMap);
            Chi2_XB(1,i)      = LOSS_VALUE(x_better, INFO, Loss_fun_MSE);
            Loss              = LOSS_VALUE(x_better, INFO, Loss_fun_CorMap);
            Result(i,:)       = [table2array(x_better) Loss];
            Cal_process_end(tim_b);
            Cal_process_end(tim_total);

            if Loss <= stop_loss
                break
            end
    end 
    CorM_history       = [CorM_X0; CorM_XF; CorM_XB];
    Chi2_history       = [Chi2_X0; Chi2_XF; Chi2_XB];
    [Best_num, Output] = DATASET2OUTPUT(Result, INFO);
    var_value = VAR_INVERSE_NORMALIZATION(XB(Best_num,:), INFO);
    VSAS_main = VSAS_main.setVarValue(table2array(var_value));

%% TOTAL TIME COST 计算总耗时
    Total_time = round(toc(t),2);
    Mean_time  = round(Total_time / fit_times, 2);
    color      = [1, 0.5, 0];
    cprintf(color, strcat('Total time used:', 32, num2str(Total_time), 's\n'));
                      
%% OUTPUT TO USER 针对用户输出
    Save_Path                 = [PathName, time_text, '\']; 
    Save_Name                 = [SampleName(1:end - 4), '-', time_text];
    report                    = OUTPUT_REPORT(Best_num, XB, Chi2_history, CorM_history, Max_Patch_XB, P_Value_XB, INFO);
    X_Best                    = report(Best_num,:);
    final_result              = OUTPUT_FINALREPORT(X_Best, SampleName, Total_time, Mean_time, fit_times, INFO);
    Final_report(1, :)        = final_result;
    
    result_table.X0           = {X0};
    result_table.XF           = {XF};
    result_table.XB           = {XB};
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
    
    VSAS_main.result_table    = result_table;
    VSAS_main = VSAS_main.fitFinish();
    
    if exist(Save_Path, 'dir') == 0                                         % 若该文件夹不存在，则直接创建
        mkdir(Save_Path);
    end
    
    save([Save_Path,'result_table.mat'], 'result_table');
    
end
