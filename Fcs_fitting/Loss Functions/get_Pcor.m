function p = get_Pcor(~, ~, VAR, INFO)
    
    max_patch = MAX_PATCH(VAR, INFO);
    if max_patch > 100
        p = 0;
    else
        p = INFO.P_Value_Table{1}(INFO.Data_size+1, max_patch);
    end
end