function [sub] = Cal_process_sub_start(prefix_str, curr_cycle, total_cycle)
sub = tic();
color = 'text';
if(curr_cycle == 1) cprintf(color, strcat('\t\t', prefix_str, 32, num2str(curr_cycle), '/', num2str(total_cycle))); end %#ok<*SEPEX>
end

