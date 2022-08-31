function GuinierSliderQMinCallback(hObject,~)
    global VSAS_main
    Para_qmin = round((get(hObject, 'Value')), 2);
    set(VSAS_main.wd_guinier_editTestqmin, 'String', num2str(Para_qmin));
    if VSAS_main.guinier_q_mode == 1
        qmin = Para_qmin.^2;
    elseif VSAS_main.guinier_q_mode == 2
        qmin = Para_qmin.^VSAS_main.guinier_para_alpha;
    end
    if VSAS_main.guinier_state_open_left == 0
        GuinierOpenStateLeft();
        VSAS_main.guinier_state_open_left = 1;
    end
    
    % 设置 qmin 参数
    VSAS_main.guinier_para_qmin = qmin;
    
    VSAS_main.guinier_line_left.XData = [qmin, qmin];
    VSAS_main.guinier_text_left.Position = [VSAS_main.guinier_line_left.XData(1), VSAS_main.guinier_line_left.YData(1)];
end