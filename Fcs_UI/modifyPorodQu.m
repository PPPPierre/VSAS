function modifyPorodQu(h0bject, ~)
    global VSAS_main
    current_porodqu = get(h0bject, 'Value');
    if current_porodqu == 1
        VSAS_main.guinier_con1 = 1;
    else
        VSAS_main.guinier_con1 = 0;
    end
end