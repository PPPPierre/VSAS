function GuinierSliderQMaxCallback(hObject, ~)
    global VSAS_main
    Para_qmax = round((get(hObject, 'Value')), 2);
    set(VSAS_main.wd_guinier_editTestqmax, 'String', num2str(Para_qmax));
    if VSAS_main.guinier_q_mode == 1
        qmax = Para_qmax.^2;
    elseif VSAS_main.guinier_q_mode == 2
        qmax = Para_qmax.^VSAS_main.guinier_para_alpha;
    end
    if VSAS_main.guinier_state_open_right == 0
        GuinierOpenStateRight();
        VSAS_main.guinier_state_open_right = 1;
    end
    
    % 设置 qmax 参数
    VSAS_main.guinier_para_qmax = qmax;
    
    VSAS_main.guinier_line_right.XData = [qmax, qmax];
    VSAS_main.guinier_text_right.Position = [VSAS_main.guinier_line_right.XData(1), VSAS_main.guinier_line_right.YData(2)];
end

