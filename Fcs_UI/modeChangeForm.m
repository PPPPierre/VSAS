function modeChangeForm(hObject, ~)
    global VSAS_main
    VSAS_main.mode_form = num2str(get(hObject, 'value'));
    VSAS_main = VSAS_main.modelRefresh();
end