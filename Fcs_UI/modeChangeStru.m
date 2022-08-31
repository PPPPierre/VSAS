function modeChangeStru(hObject, ~)
    global VSAS_main
    VSAS_main.mode_stru = num2str(get(hObject, 'value'));
    VSAS_main = VSAS_main.modelRefresh();
end