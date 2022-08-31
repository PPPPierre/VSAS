function GuinierGuinierFitStartButtonCallback(~, ~)
    global VSAS_main
    GuinierPorodStartButtonCallback();
    VSAS_main.guinier_q_mode = 1;
    % load('tempo.mat', 'M');
    xlabel(VSAS_main.wd_res_fig, '$q^2$', 'Fontsize', VSAS_main.COORDINATE_FONT_SIZE, 'Interpreter', 'latex');
    ylabel(VSAS_main.wd_res_fig, '$\ln(I(q))$', 'Fontsize', VSAS_main.COORDINATE_FONT_SIZE, 'Interpreter', 'latex');
    qmin = VSAS_main.guinier_para_qmin^2;
    qmax = VSAS_main.guinier_para_qmax^2;
    VSAS_main.guinier_line_left.XData = [qmin, qmin];
    VSAS_main.guinier_line_right.XData = [qmax, qmax];
    if VSAS_main.guinier_con1 == 1
        VSAS_main.guinier_raw_data_offporod.Visible = 'on';
        NumOri = size(VSAS_main.dt_E_data, 1);
        Result = zeros(NumOri, 4);
        Result(:, 1)= VSAS_main.dt_E_data(:, 1);
        % Result(:, 2)= VSAS_main.dt_E_data(:, 2);
        Result(:, 2)= log(VSAS_main.dt_E_data(:, 2));
        for kk1 = 1:NumOri
            Result(kk1, 2)= log(exp(Result(kk1, 2))-VSAS_main.guinier_para_C/(Result(kk1,1).^(VSAS_main.guinier_para_alpha)));
        end
        delete(VSAS_main.guinier_raw_data);
        VSAS_main.guinier_result = Result;
        VSAS_main.guinier_raw_data = plot(VSAS_main.wd_res_fig, Result(:, 1).^2, Result(:, 2), '*', 'Color', 'b');
        kmax_E = max(real(Result(:, 2)));
        kmin_E = min(real(Result(:, 2)));
        index = intersect(find(Result(:, 1)>= VSAS_main.guinier_para_qmin), find(Result(:, 1)<= VSAS_main.guinier_para_qmax));
        xx = VSAS_main.dt_E_data(index, 1).^2;
        yy = log(VSAS_main.dt_E_data(index, 2));
        % yy = VSAS_main.dt_E_data(index, 2);
    else
        VSAS_main.guinier_raw_data_offporod.Visible = 'off';
        delete(VSAS_main.guinier_raw_data);
        VSAS_main.guinier_raw_data = plot(VSAS_main.wd_res_fig, VSAS_main.dt_E_data(:, 1).^2, VSAS_main.dt_E_data(:, 2), '*', 'Color', 'b');
        kmax_E = max(VSAS_main.dt_E_data(:, 2));
        kmin_E = min(VSAS_main.dt_E_data(:, 2));
        index = intersect(find(VSAS_main.dt_E_data(:, 1)>= VSAS_main.guinier_para_qmin), find(VSAS_main.dt_E_data(:, 1)<= VSAS_main.guinier_para_qmax));
        xx = VSAS_main.dt_E_data(index, 1).^2;
        yy = log(VSAS_main.dt_E_data(index, 2));
        % yy = VSAS_main.dt_E_data(index, 2);
    end
    % Fitting
    p = polyfit(xx, yy, 1);
    y1 = polyval(p, xx);
    % Incertainty analysis
    slice_size = size(xx);
    n = slice_size(1);
    sigma = sqrt(sum((yy - y1).^2)/(n - 2));
    std_xx = sqrt(sum((xx - mean(xx)).^2)/n);
    sigma_R = sigma/(sqrt(n)*std_xx)
    delete(VSAS_main.guinier_fitting_line);
    VSAS_main.guinier_fitting_line = plot(VSAS_main.wd_res_fig, xx, y1, 'r', 'linewidth', 2);
    hold on;
    kmax_fit = max(y1);
    kmin_fit = min(y1);
    kmin = min(kmin_fit, kmin_E);
    kmax = max(kmax_fit, kmax_E);
    VSAS_main.guinier_line_left.YData = [kmin, kmax];
    VSAS_main.guinier_line_right.YData = [kmin, kmax];
    VSAS_main.guinier_text_left.Position = [VSAS_main.guinier_line_left.XData(1), VSAS_main.guinier_line_left.YData(1)];
    VSAS_main.guinier_text_right.Position = [VSAS_main.guinier_line_right.XData(1), VSAS_main.guinier_line_right.YData(2)];
    hold on;
    % axis([0-0.05 VSAS_main.dt_q_max+0.05 kmin-0.2 kmax+0.2])
    axis([0-0.05 qmax+0.05 kmin-0.2 kmax+0.2])
    VSAS_main.guinier_para_Rg = sqrt(-3*p(1));
    VSAS_main.guinier_para_Rsp = VSAS_main.guinier_para_Rg/sqrt(3/5);
    corr = corrcoef(xx,yy);
    Para_corrcoef_Guinier = abs(round(corr(1,2),3));
    VSAS_main.show('m_panel_result');
    VSAS_main.show('m_label_result_Rg');
    VSAS_main.show('m_label_result_Rsp');
    VSAS_main.show('m_result_Rg');
    VSAS_main.show('m_result_Rgsp');
    VSAS_main.show('m_label_corrcoef_Guinier');
    VSAS_main.show('m_result_corrcoef_Guinier');
    % set(obj.wd_guinier_outputButton, 'Enable', 'On');
    set(VSAS_main.wd_guinier_Rg_result, 'String', sprintf('%.3f', VSAS_main.guinier_para_Rg));
    set(VSAS_main.wd_guinier_Rsp_result, 'String', sprintf('%.3f', VSAS_main.guinier_para_Rsp));
    set(VSAS_main.wd_guinier_corrcoef_Guinier_result, 'String', sprintf('%.3f', Para_corrcoef_Guinier));

end