function stopButtonCallback(hObject,~)

    global VSAS_main
    set(hObject, 'Enable', 'off');
    VSAS_main.flag_fit = 0;
    
end