function myMessageBox(message,title)
    global VSAS_main;
    if nargin == 1
        mb = msgbox(message,'Attention!');
    else
        mb = msgbox(message,title);
    end
    text = findobj(mb);
    set(text(1), 'position', [(VSAS_main.window_width)/2 (VSAS_main.window_height)/2 176 90]);
    set(text(2), 'position', [63 15 50 20]);
    set(text(4), 'Position', [10 50], 'HorizontalAlignment', 'Left', 'FontName', VSAS_main.FONT_NAME, 'FontSize', VSAS_main.LABEL_FONT_SIZE);
end