function modeChangeDist(hObject, ~)
    global VSAS_main
    VSAS_main.mode_dist = num2str(get(hObject, 'value'));
    VSAS_main = VSAS_main.modelRefresh();
end