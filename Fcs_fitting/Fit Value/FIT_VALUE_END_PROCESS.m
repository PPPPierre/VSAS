function V = FIT_VALUE_END_PROCESS(res, INFO)
    V = log(res);
    % V = 10 * (log(res) - INFO.E_min + 0.1)./(INFO.E_max - INFO.E_min + 0.1);
    % V = (log(res) - INFO.E_mean)./INFO.E_std;  
end