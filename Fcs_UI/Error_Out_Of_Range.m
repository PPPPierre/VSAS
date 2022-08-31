function Error_Out_Of_Range()
    global VSAS_main;
    mb = msgbox('Out of range. Please set again!','Error');
    text = findobj(mb);
    set(text(4), 'HorizontalAlignment', 'left', 'FontName', VSAS_main.FONT_NAME, 'FontSize', VSAS_main.LABEL_FONT_SIZE);
    set(text(1), 'position', [(VSAS_main.window_width)/2 (VSAS_main.window_height)/2 176 90]);
    set(text(2), 'position', [63 15 50 20]);
    set(text(4), 'Position', [10 50]);

end