function [obj, res] = show(obj, name)
    objs = findall(obj.wd_main_window, 'Tag', name);
    set(objs(1), 'Visible', 'on');
    res = objs(1);
end