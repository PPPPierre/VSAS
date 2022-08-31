function loadButtonCallback(~, ~)
    global VSAS_main;
    [VSAS_main.file_name, VSAS_main.file_path] = uigetfile('*.txt', 'Select data file');
    if VSAS_main.file_path ~= 0
        data_file = strcat(VSAS_main.file_path, VSAS_main.file_name);
        try
            E = importdata(data_file);
        catch
            return
        end
        save([VSAS_main.main_path, 'tempo.mat'], 'E');
        VSAS_main = VSAS_main.resetResFig();
        VSAS_main = VSAS_main.loadData(E.data);
        VSAS_main.showDataFileName();
        programmeModeSwitch(VSAS_main.wd_popmenu_mode);
    end
end