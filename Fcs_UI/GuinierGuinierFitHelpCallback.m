function GuinierGuinierFitHelpCallback(~, ~)
    global VSAS_main
    mb = msgbox({'To calculate Rg by Ginier approach', '  - Choose q range', '  - Start to fit Rg'}, 'Help', VSAS_main.CREATE_STRUCT);
    text = findobj(mb);
    set(text(4), 'HorizontalAlignment', 'left', ...
        'FontName', VSAS_main.FONT_NAME, 'FontSize', VSAS_main.LABEL_FONT_SIZE); 
    sz = [200 110];
    xpos = ceil(VSAS_main.window_width/2);
    ypos = ceil(VSAS_main.window_height/2);
    set(text(1), 'position', [xpos ypos sz(1) sz(2)]); 
    set(text(2), 'position', [63 15 50 20], 'String', 'I know', ...
        'FontName', VSAS_main.FONT_NAME, 'FontSize', VSAS_main.LABEL_FONT_SIZE); 
    set(text(4), 'Position', [10 50]);
end