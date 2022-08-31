function obj = clearAll(obj, name)
    if nargin == 1
        % 寻找所有wd_main_window上'Tag'中带‘^m_'的控件
        objs = findall(obj.wd_main_window, '-regexp', 'Tag', '^m_');
        set(objs, 'Visible', 'off');
    else
        % 寻找所有wd_main_window上'Tag'中带输入参数name的控件
        objs = findall(obj.wd_main_window, '-regexp', 'Tag', name); 
        set(objs, 'Visible', 'off');
    end
end