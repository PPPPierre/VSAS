function qUnitPopmenuCallback(hObject, ~)
    global VSAS_main
    VSAS_main.q_unit = get(hObject, 'value');
    VSAS_main = VSAS_main.rawDataParse();
    if VSAS_main.flag_load_data()
        VSAS_main = VSAS_main.resetResFig();
        VSAS_main.plotExpDataPoint();
    end
end