function outputButtonCallback(~,~)

    global VSAS_main
    flag = saveFitResult(VSAS_main.result_table, VSAS_main.FIT_INFO.INFO);
    if flag == 1
        message = 'Save finished!';
        myMessageBox(message);
    end
    
end