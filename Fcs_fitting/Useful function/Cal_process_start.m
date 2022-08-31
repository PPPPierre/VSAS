function [p] = Cal_process_start(prefix_str, curr_cycle, total_cycle)
    p     = tic();
    color = 'text';
    cprintf(color, strcat(prefix_str, 32, num2str(curr_cycle), '/', num2str(total_cycle), 10));
end

