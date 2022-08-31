function GuinierPorodStartButtonCallback(~, ~)
    global VSAS_main
    VSAS_main.guinier_raw_data_offporod.Visible = 'Off';
    VSAS_main.guinier_para_alpha = str2double(get(VSAS_main.wd_guinier_editTestalpha, 'String'));
    if VSAS_main.guinier_para_alpha == 0
        C_zero_detected();
        return;
    end
    VSAS_main.guinier_q_mode = 2; % q_mode_Porod = 2
    % load('tempo.mat', 'M');
    xlabel(VSAS_main.wd_res_fig, '$q^{\alpha}$', 'Fontsize', VSAS_main.COORDINATE_FONT_SIZE, 'Interpreter', 'latex');
    ylabel(VSAS_main.wd_res_fig, '$I(q)\cdot q^{\alpha}$', 'Fontsize',VSAS_main. COORDINATE_FONT_SIZE, 'Interpreter', 'latex');
    VSAS_main.guinier_para_alpha = str2double(get(VSAS_main.wd_guinier_editTestalpha, 'String'));
    delete(VSAS_main.guinier_raw_data);
    xx = VSAS_main.dt_E_data(:, 1).^VSAS_main.guinier_para_alpha;
    %yy = exp(VSAS_main.dt_E_data(:, 2)).*(VSAS_main.dt_E_data(:, 1).^VSAS_main.guinier_para_alpha);
    yy = VSAS_main.dt_E_data(:, 2).*(VSAS_main.dt_E_data(:, 1).^VSAS_main.guinier_para_alpha);
    VSAS_main.guinier_raw_data = plot(VSAS_main.wd_res_fig, xx, yy, '*', 'Color', 'b');
    hold on;
    kmax_E = max(yy);
    kmin_E = min(yy);
    index = intersect(find((VSAS_main.dt_E_data(:, 1))>= VSAS_main.guinier_para_qmin), find((VSAS_main.dt_E_data(:, 1))<= VSAS_main.guinier_para_qmax));
    xx_slice = VSAS_main.dt_E_data(index, 1).^VSAS_main.guinier_para_alpha;
    %yy_slice = exp(VSAS_main.dt_E_data(index, 2)).*(VSAS_main.dt_E_data(index, 1).^VSAS_main.guinier_para_alpha);
    yy_slice = VSAS_main.dt_E_data(index, 2).*(VSAS_main.dt_E_data(index, 1).^VSAS_main.guinier_para_alpha);
    % Fitting
    p = polyfit(xx_slice, yy_slice, 1);
    y1 = polyval(p, xx_slice);
    % Incertainty analysis
    slice_size = size(xx_slice);
    n = slice_size(1);
    sigma = (sum((yy_slice - y1).^2)/(n - 2))^(1/2);
    std_xx_slice = sqrt(sum((xx_slice - mean(xx_slice)).^2)/n);
    sigma_C = sigma/sqrt(n)*sqrt(1+mean(xx_slice)^2/std_xx_slice^2)
    sigma_Ibg = sigma/(sqrt(n)*std_xx_slice)
    kmax_fit = max(y1);
    kmin_fit = min(y1);
    kmax = max(kmax_E, kmax_fit);
    kmin = min(kmin_E, kmin_fit);
    VSAS_main.guinier_para_qmin = str2double(get(VSAS_main.wd_guinier_editTestqmin, 'String'));
    VSAS_main.guinier_para_qmax = str2double(get(VSAS_main.wd_guinier_editTestqmax, 'String'));
    qmin = VSAS_main.guinier_para_qmin.^VSAS_main.guinier_para_alpha;
    qmax = VSAS_main.guinier_para_qmax.^VSAS_main.guinier_para_alpha;
    VSAS_main.guinier_line_left.XData = [qmin, qmin];
    VSAS_main.guinier_line_left.YData = [kmin, kmax];
    VSAS_main.guinier_line_right.XData = [qmax, qmax];
    VSAS_main.guinier_line_right.YData = [kmin, kmax];
    VSAS_main.guinier_text_left.Position = [VSAS_main.guinier_line_left.XData(1), VSAS_main.guinier_line_left.YData(1)];
    VSAS_main.guinier_text_right.Position = [VSAS_main.guinier_line_right.XData(1), VSAS_main.guinier_line_right.YData(2)];
    hold on;
    % axis([0-0.05 VSAS_main.dt_q_max+0.05 kmin-0.2 kmax+0.2])
    axis([0-0.05 max(xx)+0.05 kmin-0.02 kmax+0.02])
    VSAS_main.guinier_para_C = p(2);
    VSAS_main.guinier_para_Ibg_porod = p(1);
    corr = corrcoef(xx_slice,yy_slice) ;
    Para_corrcoef_Porod = abs(round(corr(1,2),3));
    delete(VSAS_main.guinier_fitting_line);
    VSAS_main.guinier_fitting_line = plot(VSAS_main.wd_res_fig, xx_slice, y1, 'Color', 'r', 'linewidth', 2);
    hold on;
    VSAS_main.show('m_panel_result');
    VSAS_main.show('m_label_result_C');
    VSAS_main.show('m_result_C');
    VSAS_main.show('m_label_result_laue');
    VSAS_main.show('m_result_laue');
    VSAS_main.show('m_label_corrcoef_Porod');
    VSAS_main.show('m_result_corrcoef_Porod');
    set(VSAS_main.wd_guinier_outputButton, 'Enable', 'On');
    set(VSAS_main.wd_guinier_C_result, 'String', sprintf('%.3f', VSAS_main.guinier_para_C));
    set(VSAS_main.wd_guinier_Ibg_result, 'String', sprintf('%.3f', VSAS_main.guinier_para_Ibg_porod));
    set(VSAS_main.wd_guinier_corrcoef_Porod_result, 'String', sprintf('%.3f', Para_corrcoef_Porod));
end

function C_zero_detected()
    global VSAS_main
    mb = msgbox({'�� = 0 detected. Please set �� value.'}, VSAS_main.CREATE_STRUCT);
    text = findobj(mb);
    set(text(4), 'HorizontalAlignment', 'left', 'FontName', VSAS_main.FONT_NAME, 'FontSize', VSAS_main.LABEL_FONT_SIZE);
    screensize = get(0, 'ScreenSize');
    sz = [185 80];
    xpos = ceil((screensize(3)-sz(1))/2);
    ypos = ceil((screensize(4)-sz(2))/2);
    set(text(1), 'position', [xpos ypos sz(1) sz(2)]);
    set(text(2), 'position', [63 15 50 20], 'String', 'I know', 'FontName', VSAS_main.FONT_NAME, 'FontSize', VSAS_main.LABEL_FONT_SIZE);
    set(text(4), 'Position', [10 50]);
end