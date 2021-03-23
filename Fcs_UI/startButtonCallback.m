function startButtonCallback(~, ~)

    global VSAS_main
    VSAS_main = VSAS_main.startFittingProgram();
    startAutoFitting();
    
end