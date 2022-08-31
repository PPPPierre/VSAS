function GuinierTextQMaxCallback(hObject, ~)
    global VSAS_main
    max_qmax = get(VSAS_main.wd_guinier_sliderqmax, 'Max');
    min_qmax = get(VSAS_main.wd_guinier_sliderqmax, 'Min');
    current_qmax = str2double(get(hObject, 'String'));
    if current_qmax<= max_qmax&&current_qmax>= min_qmax
        Para_qmax = str2double(get(hObject, 'String'));
        set(VSAS_main.wd_guinier_sliderqmax, 'Value', Para_qmax);
        if VSAS_main.guinier_q_mode == 1
            qmax = Para_qmax.^2;
        elseif VSAS_main.guinier_q_mode == 2 %
            qmax = Para_qmax.^VSAS_main.guinier_para_alpha;
        end
        if VSAS_main.guinier_state_open_right == 0
            GuinierOpenStateRight();
            VSAS_main.guinier_state_open_right = 1;
        end
        
        VSAS_main.guinier_para_qmax = current_qmax;
        VSAS_main.guinier_line_right.XData = [qmax, qmax];
        VSAS_main.guinier_text_right.Position = [VSAS_main.guinier_line_right.XData(1), VSAS_main.guinier_line_right.YData(2)];
    else
        mb = msgbox('Out of range. Please set again!');
        text = findobj(mb);
        set(text(4), 'HorizontalAlignment', 'left', 'FontName', FONT_NAME, 'FontSize', LABEL_FONT_SIZE);
        set(text(1), 'position', [400 250 176 90]);
        set(text(2), 'position', [63 15 50 20]);
        set(text(4), 'Position', [10 50]);
    end
end