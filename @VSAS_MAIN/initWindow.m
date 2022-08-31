function obj = initWindow(obj)
    % 1. create the window
    obj.wd_main_window     = figure();
    obj.screen_size = get(0, 'ScreenSize'); % 获取计算机屏幕分辨率
    set(obj.wd_main_window, 'NumberTitle', 'Off');
    set(obj.wd_main_window, ...
        'Visible', 'On', ...
        'Name', 'VSAS', ...
        'Color', [0.941, 0.941, 0.941], ...
        'menubar','none', ...
        'Resize', 'Off', ...
        'Position', [(obj.screen_size(3)-obj.window_width)/2, ... 
                     (obj.screen_size(4)-obj.window_height)/2, ...
                     obj.window_width, ...
                     obj.window_height]);
    % 2. try to delete "tempo.mat"
    try
        delete('tempo.mat')
    catch
    end
    % 3. create menu "VSAS"
    about_VSAS = uimenu('Parent', obj.wd_main_window, ...
                        'label', 'About VSAS', ...
                        'Callback', @copyright); %#ok<NASGU>
end