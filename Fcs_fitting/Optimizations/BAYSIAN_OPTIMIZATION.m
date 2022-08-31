function [BO_result] = BAYSIAN_OPTIMIZATION(INFO, loss_func)

    fun_bayes = @(x)LOSS_VALUE(x, INFO, loss_func);                         % DefBine the objectif function
    ParRange  = INFO.ParRange_Norm;                                         % 归一化后的参数范围
    Num       = INFO.ParNum;
    VarNames  = INFO.VarNames;

    %% Variables declaration 声明可优化参数
    Var = [];
    for i = 1:Num 
        Var = [Var optimizableVariable(VarNames{i}, ParRange{i})];
    end

    %% BAYES optimisation
    results = bayesopt(fun_bayes, Var,...
        'MaxObjectiveEvaluations',  INFO.Bayes_MaxObjectiveEvaluations  ,...
        'AcquisitionFunctionName',  INFO.Bayes_AcquisitionFunctionName  ,...  
        'NumSeedPoints',            INFO.Bayes_NumSeedPoints            ,...                                     
        'ExplorationRatio',         INFO.Bayes_ExplorationRatio         ,...                                 
        'IsObjectiveDeterministic', INFO.Bayes_IsObjectiveDeterministic ,...
        'Verbose',                  1                                   ,...
        'PlotFcn',                  []                                   ...
        );                               

    BO_result = results;
end
