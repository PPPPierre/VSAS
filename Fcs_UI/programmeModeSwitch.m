function programmeModeSwitch(hObject, ~)
    global VSAS_main
    VSAS_main = VSAS_main.resetResFig();
    VSAS_main.function_mode = get(hObject, 'value');
    % VSAS_main.clearAll();
    xlabel(VSAS_main.wd_res_fig, '');
    ylabel(VSAS_main.wd_res_fig, '');
    
    VSAS_main = VSAS_main.clearAll();
    
    if VSAS_main.function_mode ~= 1
        VSAS_main.show('m_choose_text');
        VSAS_main.show('m_load_button');
    end
    
    % load 'tempo.mat' file
%     if exist('tempo.mat','file') == 0
%         return;
%     else
%         load([VSAS_main.main_path, 'tempo.mat'], 'E');
%         VSAS_main = VSAS_main.loadData(E.data);
%     end
    
    % Mode switch
    if VSAS_main.flag_load_data == 1
        switch VSAS_main.function_mode
            case 2
                VSAS_main = VSAS_main.initGuinierPanel();
                VSAS_main = VSAS_main.showGuinierPanel();
            case 3
                VSAS_main = VSAS_main.initDisFitPanel();
                VSAS_main = VSAS_main.showDisFitPanel();
                VSAS_main.plotExpDataPoint();
                drawnow();
                % VSAS_main.plotExpDataPoint();
        end
    end
    
end