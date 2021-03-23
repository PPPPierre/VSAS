function outputButtonCallback(~,~)

    global VSAS_main
    saveFitResult(VSAS_main.result_table, VSAS_main.FIT_INFO.INFO)
    message = 'Save finished!';
    myMessageBox(message);
    
end