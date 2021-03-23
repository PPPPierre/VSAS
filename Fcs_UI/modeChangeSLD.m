function modeChangeSLD(hObject, ~)
    global VSAS_main
    VSAS_main.mode_sld = num2str(get(hObject, 'value'));
    VSAS_main = VSAS_main.modelRefresh();
end