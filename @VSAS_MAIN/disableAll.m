function obj = disableAll(obj, name)
    wd_cell = {'popupmenu', 'pushbutton', 'slider', 'edit'};
    if nargin == 1
        % 寻找所有wd_main_window上'Tag'中带‘^m_'的控件
        objs = findall(obj.wd_main_window, '-regexp', 'Tag', '^m_');
        for i = 1:length(objs)
            if strcmp(objs(i).Type, 'uicontrol')
                if ismember(objs(i).Style, wd_cell) 
                    set(objs(i), 'Enable', 'off');
                end
            end
        end
        
    else
        % 寻找所有wd_main_window上'Tag'中带输入参数name的控件
        objs = findall(obj.wd_main_window, '-regexp', 'Tag', name); 
        for i = 1:length(objs)
            if strcmp(objs(i).Type, 'uicontrol')
                if ismember(objs(i).Style, wd_cell) 
                    set(objs(i), 'Enable', 'off');
                end
            end
        end
    end
end