function Cal_process_end(p)
    time_txt = num2str(toc(p));
    len = length(time_txt);
    pos_point = find(time_txt == '.') ;
    if (len - pos_point == 1)
        time = time_txt(1: pos_point + 1);
    else
        time = time_txt(1: pos_point + 2);
    end
    color = [1, 0.5, 0];  %orange
    cprintf(color, strcat('\t', 'Total time used:', 32, time, 's\n'));
end

