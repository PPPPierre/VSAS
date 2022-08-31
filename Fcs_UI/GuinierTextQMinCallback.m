function GuinierTextQMinCallback(hObject, ~)
    global VSAS_main
    max_qmin = get(VSAS_main.wd_guinier_sliderqmin, 'Max');
    min_qmin = get(VSAS_main.wd_guinier_sliderqmin, 'Min');
    current_qmin = str2double(get(hObject, 'String'));
    if current_qmin<= max_qmin&&current_qmin>= min_qmin
        Para_qmin = str2double(get(hObject, 'String'));
        set(VSAS_main.wd_guinier_sliderqmin, 'Value', Para_qmin);
        if VSAS_main.guinier_q_mode == 1
            qmin = Para_qmin.^2;
        elseif VSAS_main.guinier_q_mode == 2
            qmin = Para_qmin.^VSAS_main.guinier_para_alpha;
        end
        if VSAS_main.guinier_state_open_left == 0
            GuinierOpenStateLeft();
            VSAS_main.guinier_state_open_left = 1;
        end
        VSAS_main.guinier_para_qmin = current_qmin;
        VSAS_main.guinier_line_left.XData = [qmin, qmin];
        VSAS_main.guinier_text_left.Position = [VSAS_main.guinier_line_left.XData(1), VSAS_main.guinier_line_left.YData(1)];
    else
        mb = msgbox('Out of range. Please set again!');
        text = findobj(mb);
        set(text(4), 'HorizontalAlignment', 'left', 'FontName', VSAS_main.FONT_NAME, 'FontSize', VSAS_main.LABEL_FONT_SIZE);
        set(text(1), 'position', [400 250 176 90]);
        set(text(2), 'position', [63 15 50 20]);
        set(text(4), 'Position', [10 50]);
    end
end