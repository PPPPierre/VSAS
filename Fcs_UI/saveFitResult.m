function saveFitResult(result_table, info)

    re_table = result_table;
    INFO = info;
    
    % 设定存储路径
    Save_Name = re_table.Save_Name{1};
    Target_Path = uigetdir('*.*', 'Please choose the save path.');
    Save_Path = [Target_Path, '\', re_table.time_text{1}, '\']; 
    if exist(Save_Path, 'dir') == 0                                         % 若该文件夹不存在，则直接创建
        mkdir(Save_Path);
    end

    % 保存CorMap
    plot_num = re_table.Best_num;
    % plot_num = 2;
    V0       = FIT_VALUE(re_table.X0{1}(plot_num,:), INFO);
    VF       = FIT_VALUE(re_table.XF{1}(plot_num,:), INFO);
    VB       = FIT_VALUE(re_table.XB{1}(plot_num,:), INFO);
    Final_report = re_table.Final_report;
    
    % CorMap
    % CorM     = corr([VB; INFO.E]);
    CorM     = corr([VB; INFO.E_stand]);
    % num1     = LONG_CON(CorM(1,:), 1);
    % num2     = LONG_CON(CorM(1,:), -1);
    % CorM_Max = max([num1, num2]);
    F        = figure('visible', 'off');
    imshow(CorM);
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10]);
    saveas(F, [Save_Path, Save_Name, '_CorM'], 'jpg');
    close;
   
    % 保存拟合图像
    F        = figure('visible', 'off');
    % chi2     = LOSS_VALUE(XB(plot_num,:), INFO, Loss_fun_MSE);
    % Grid     = LOSS_VALUE(XB(plot_num,:), INFO, Loss_fun_CorMap);
    hold on;
    plot(INFO.Q, INFO.E_stand, '*k', 'MarkerSize', 15 ,'LineWidth', 1.5);
    % plot(INFO.Q, INFO.E, '*k', 'MarkerSize', 15 ,'LineWidth', 1.5);
    % plot(INFO.Q, V0, 'b', 'LineWidth', 1.5);
    % plot(INFO.Q, VF, 'g', 'LineWidth', 1.5);
    plot(INFO.Q, VB, 'r', 'LineWidth', 1.5);
    title('Visualisation of fitting');
%   legend('Experimental data', ...
%        'Bayian Opt', ...
%        'Gradient descent', ...
%        'Grid Search');
    xlabel('q / nm-1');
    ylabel('log(I(q)) (Std)');
    set(gca,'FontSize',35); 
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10]);
    saveas(F, [Save_Path, Save_Name], 'jpg');
    close;

%% SAVE EXCEL 保存最终数据
    
    save([Save_Path,'Final Report.mat'], 'Final_report');
    ColumnNames            = re_table.Final_report.Properties.VariableNames;
    Final_report_cellarray = [ColumnNames;table2cell(re_table.Final_report)];
    xlswrite([Save_Path, '\Final Report.xls'], Final_report_cellarray);
    DataNum = 1;
    DRAW_R_DISS([Save_Path, '\Final Report.xls'], DataNum, Save_Path);
    
end