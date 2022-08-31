function GuinierTextAlphaCallback(hObject, ~)
    global VSAS_main
    max_alpha = get(VSAS_main.wd_guinier_slideralpha, 'Max');
    min_alpha = get(VSAS_main.wd_guinier_slideralpha, 'Min');
    current_alpha = str2double(get(hObject, 'String'));
    if current_alpha<= max_alpha&&current_alpha>= min_alpha
        set(VSAS_main.wd_guinier_slideralpha, 'Value', str2double(get(hObject, 'String')));
    else
        mb = msgbox('Out of range. Please set again!');
        text = findobj(mb);
        set(text(4), 'HorizontalAlignment', 'left', 'FontName', VSAS_main.FONT_NAME, 'FontSize', VSAS_main.LABEL_FONT_SIZE)
        set(text(1), 'position', [400 20 176 90]);
        set(text(2), 'position', [63 15 50 20]);
        set(text(4), 'Position', [10 50]);
    end
end