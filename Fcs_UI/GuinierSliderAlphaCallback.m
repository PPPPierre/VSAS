function GuinierSliderAlphaCallback(hObject,~)
    global VSAS_main
    set(VSAS_main.wd_guinier_editTestalpha, 'String', num2str(round((get(hObject, 'Value')), 2)));
end