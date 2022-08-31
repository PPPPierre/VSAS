function Bind_slider_text(h_slider, h_edit_text, par_name)
    fun_slider    = @(hObject, handle)Modify_Slider(hObject, h_edit_text, par_name, handle);
    fun_edit_text = @(hObject, handle)Modify_Text(hObject, h_slider, par_name, handle);
    set(h_slider, 'Callback', fun_slider);
    set(h_edit_text, 'Callback', fun_edit_text);
end