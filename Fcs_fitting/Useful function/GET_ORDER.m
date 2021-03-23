function res = GET_ORDER(x)
res = floor(round(log10(abs(x)), 5));
    if (x <= 0) 
        res = 0;
    end
end