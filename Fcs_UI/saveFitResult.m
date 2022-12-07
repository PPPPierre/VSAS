function flag = saveFitResult(result_table, info)

    global VSAS_main
    
    program_par_table = VSAS_main.FIT_INFO.program_par_table;
    valid_loss = program_par_table.stop_loss;
    
    %
    save_name = result_table.Save_Name{1};
    target_path = uigetdir('*.*', 'Please choose the save path.');
    flag = 0;
    if target_path ~= 0
        save_path = [target_path, '\', result_table.time_text{1}, '\'];
        if exist(save_path, 'dir') == 0                                         % �����ļ��в����ڣ���ֱ�Ӵ���
            mkdir(save_path);
        end
        % ����CorMap
        plot_num = result_table.Best_num;
        % plot_num = 2;
        V0       = FIT_VALUE(result_table.X0{1}(plot_num,:), info);
        VF       = FIT_VALUE(result_table.XF{1}(plot_num,:), info);
        VB       = FIT_VALUE(result_table.XB{1}(plot_num,:), info);
        Final_report = result_table.Final_report;

        % CorMap
        % CorM     = corr([VB; INFO.E]);
        CorM     = corr([VB; info.E]);
        % num1     = LONG_CON(CorM(1,:), 1);
        % num2     = LONG_CON(CorM(1,:), -1);
        % CorM_Max = max([num1, num2]);
        F        = figure('visible', 'off');
        imshow(CorM);
        set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10]);
        saveas(F, [save_path, save_name, '_CorM'], 'jpg');
        close;

        % �������ͼ��
        F        = figure('visible', 'off');
        % chi2     = LOSS_VALUE(XB(plot_num,:), INFO, Loss_fun_MSE);
        % Grid     = LOSS_VALUE(XB(plot_num,:), INFO, Loss_fun_CorMap);
        hold on;
        plot(info.Q, info.E, '*k', 'MarkerSize', 17 ,'LineWidth', 1.5);
        % plot(INFO.Q, INFO.E, '*k', 'MarkerSize', 15 ,'LineWidth', 1.5);
        % plot(INFO.Q, V0, 'b', 'LineWidth', 1.5);
        % plot(INFO.Q, VF, 'g', 'LineWidth', 1.5);
        plot(info.Q, VB, 'r', 'LineWidth', 1.5);
        title('Visualisation of fitting');
    %   legend('Experimental data', ...
    %        'Bayian Opt', ...
    %        'Gradient descent', ...
    %        'Grid Search');
        xlabel('q / nm-1');
        ylabel('log(I(q))');
        grid on;
        set(gca,'FontSize',35); 
        set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10]);
        saveas(F, [save_path, save_name], 'jpg');
        close;
        
    %% SAVE FITTING RESULTS
        report = result_table.report{1};
        col_names  = report.Properties.VariableNames;
        table_size = size(report);
        pos_Rm2 = ismember(col_names, 'Rm2');
        
        if sum(pos_Rm2) > 0
            pos_Rm1 = ismember(col_names, 'Rm1');
            pos_sigma1 = ismember(col_names, 'sigma1');
            pos_sigma2 = ismember(col_names, 'sigma2');
            pos_fv1 = ismember(col_names, 'fV1');
            if sum(pos_fv1) == 0
                pos_fv1 = ismember(col_names, 'fV1rho2');
                pos_fv2 = ismember(col_names, 'fV2rho2');
            else
                pos_fv2 = ismember(col_names, 'fV2');
            end
            for row = 1:table_size(1)
                if report{row, pos_Rm1} > report{row, pos_Rm2} 
                    tmp_Rm2 = report{row, pos_Rm2};
                    tmp_fv2 = report{row, pos_fv2};
                    tmp_sigma2 = report{row, pos_sigma2};
                    report{row, pos_Rm2} = report{row, pos_Rm1};
                    report{row, pos_fv2} = report{row, pos_fv1};
                    report{row, pos_sigma2} = report{row, pos_sigma1};
                    report{row, pos_Rm1} = tmp_Rm2;
                    report{row, pos_fv1} = tmp_fv2;
                    report{row, pos_sigma1} = tmp_sigma2;
                end
            end
        end
        report_cellarray = [col_names;table2cell(report)];
%         report_cellarray;
        xlswrite([save_path, '\Report.xls'], report_cellarray);
        
    %% Get valid data
        pos_chi2 = ismember(col_names, 'Chi2');
        report_array = table2array(report);
        valid_array = report_array(report_array(:,pos_chi2) < valid_loss,:);
        valid_size = size(valid_array);
%         if valid_size(1) > 0
%             mean_Rm1 = mean(valid_array(:,pos_Rm1));
%             std_Rm1 = std(valid_array(:,pos_Rm1));
%             mean_sigma1 = mean(valid_array(:,pos_sigma1));
%             std_sigma1 = std(valid_array(:,pos_sigma1));
%             mean_fv1 = mean(valid_array(:,pos_fv1));
%             std_fv1 = std(valid_array(:,pos_fv1));
%             if sum(pos_Rm2) > 0
%                 mean_Rm2 = mean(valid_array(:,pos_Rm2));
%                 std_Rm2 = std(valid_array(:,pos_Rm2));
%                 mean_sigma2 = mean(valid_array(:,pos_sigma2));
%                 std_sigma2 = std(valid_array(:,pos_sigma2));
%                 mean_fv2 = mean(valid_array(:,pos_fv2));
%                 std_fv2 = std(valid_array(:,pos_fv2));    
%             end
%         end

        %% SAVE EXCEL ������������
        save([save_path,'Final Report.mat'], 'Final_report');
        save([save_path,'Fitting_result.mat'], 'result_table');
        column_names     = result_table.Final_report.Properties.VariableNames;
        new_column_names = [column_names 'Rmin' 'Rmax'];
        new_value_cell = [table2cell(result_table.Final_report) {info.dt_detect_scale_min} {info.dt_detect_scale_max}];
        
        idx_Ibg = find(ismember(col_names, 'Ibg') == 1);
        
        if valid_size(1) > 0
            for i = 2:idx_Ibg
                col_name = col_names{i};
                mean_val = mean(valid_array(:, i));
                std_val = std(valid_array(:, i));
                new_column_names = [new_column_names [col_name, '_mean'] [col_name, '_std']];
                new_value_cell = [new_value_cell {mean_val} {std_val}];
            end
        end
        
        final_report_cellarray = [new_column_names; new_value_cell];
        xlswrite([save_path, '\Final Report.xls'], final_report_cellarray);
        data_id = 1;
        DRAW_R_DISS([save_path, '\Final Report.xls'], data_id, save_path, floor(info.dt_detect_scale_max));
        drawRDissWithError(valid_array(:,2:7), save_path, floor(info.dt_detect_scale_max));
        flag = 1;
    end
end