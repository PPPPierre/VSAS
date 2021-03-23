function modeChangeAlpha(hObject, ~)
    global VSAS_main
    VSAS_main.mode_alpha = num2str(get(hObject, 'value'));
    VSAS_main = VSAS_main.modelRefresh();
end