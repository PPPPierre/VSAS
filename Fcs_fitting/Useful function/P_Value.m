function [P] = P_Value(n, C)
n = n - 1;
C = C - 1;
list = zeros(n, 1);
ind_1 = 1:C;
list(ind_1) = 2.^(ind_1 - 1);
for i = 1:(n-C+1)
    list(i+C) = sum(list(i:C+i-1));
end
P = 1 - list(end)/2^n;
end

