function obj = getMainPath(obj)
    p = mfilename('fullpath');
    i = strfind(p, '\');
    p = p(1:i(end-1));
    obj.main_path = p;
end