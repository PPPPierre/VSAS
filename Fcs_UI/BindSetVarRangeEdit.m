function BindSetVarRangeEdit(edit_min, edit_max, par_name)
    global VSAS_main
    idx = strcmp(VSAS_main.FIT_INFO.var_names_cell, par_name);
    fun_edit_min =  @(hObject, handle)ModifySetParEdit(hObject, idx, 1, handle);
    fun_edit_max =  @(hObject, handle)ModifySetParEdit(hObject, idx, 2, handle);
    set(edit_min, 'Callback', fun_edit_min);
    set(edit_max, 'Callback', fun_edit_max);
end