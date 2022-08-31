function Cal_process_sub_end(curr_cycle, total_cycle, sub)
time_txt = num2str(toc(sub));
len = length(time_txt);
pos_point = find(time_txt == '.') ;
if (len - pos_point == 1) time_sub = time_txt(1: pos_point + 1);
else time_sub = time_txt(1: pos_point + 2);
    
color = [1, 0.5, 0];  %orange
color2 = 'text';
if(curr_cycle == 1)
    cprintf(color, strcat('\t', 'Time used:', 32, time_sub, 's'));
else
    num = length(strcat(32, 'Time used:', 32, time_sub, 's'));
    fprintf(repmat('\b',1, length(num2str(curr_cycle - 1)) + 2 + length(num2str(total_cycle)) + num ));
    cprintf(color2, strcat(32, num2str(curr_cycle), '/', num2str(total_cycle)));
    cprintf(color, strcat('\t', 'Time used:', 32, time_sub, 's'));
end
% if(curr_cycle == total_cycle) fprintf('\n'); end    %#ok<SEPEX>
end

