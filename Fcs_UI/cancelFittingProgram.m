function cancelFittingProgram(~, ~)
    
    global VSAS_main
    VSAS_main.flag_fit = 0;
    drawnow();
    
end