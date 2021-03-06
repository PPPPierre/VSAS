function [slider, edit_text] = Create_Para_Slider_Text(parameters_panel, position, par_name, par_min, par_max, label_text, label_tag, slider_tag, text_tag)
    global VSAS_main
    position_slider = [115, position(2)-5, 130, 20];
    position_text   = [255, position_slider(2), 50, 20];
    annotation(parameters_panel, 'textbox', 'Units', 'pixel', 'Position', position, 'String', label_text, 'interpreter', 'latex', 'EdgeColor', [0.941, 0.941, 0.941], 'FontSize', VSAS_main.ANNOTATION_FONT_SIZE, 'Tag', label_tag, 'FitBoxToText', 'on', 'Visible', 'on');
    slider    = uicontrol(parameters_panel, 'Style', 'slider', 'Min',par_min, 'Max', par_max, 'Value', 0, 'Position', position_slider, 'Tag', slider_tag, 'Visible', 'on');
    edit_text = uicontrol(parameters_panel, 'Style', 'edit', 'String', '0', 'Position', position_text,'Tag', text_tag, 'Visible', 'on');
    set(slider, 'Value', par_min);
    set(edit_text, 'String', num2str(par_min));
    Bind_slider_text(slider, edit_text, par_name);
end