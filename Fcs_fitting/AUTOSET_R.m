function R_range = AUTOSET_R(Q_Data)
    max1    = pi/Q_Data(1);
    max2    = pi/min(abs(Q_Data(2:end) - Q_Data(1:end-1)));
    R_max   = min(max1, max2);
    R_min   = max(0.3, pi/Q_Data(end));
    R_range = [R_min, R_max];
end