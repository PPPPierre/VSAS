function [obj, res] = showAll(obj, name)
    if nargin == 1
        % 寻找所有wd_main_window上'Tag'中带‘^m_'的控件
        objs = findall(obj.wd_main_window, '-regexp', 'Tag', '^m_');
        for i = 1:length(objs)
            set(objs(i), 'Visible', 'on');
        end
    
    else
        % 寻找所有wd_main_window上'Tag'中带输入参数 name 的控件
        objs = findall(obj.wd_main_window, '-regexp', 'Tag', name);
        for i = 1:length(objs)
            set(objs(i), 'Visible', 'on');
        end
    end
end