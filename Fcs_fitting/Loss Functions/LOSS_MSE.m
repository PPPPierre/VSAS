function res = LOSS_MSE(V, E, ~, ~)

    n   = length(V);
    res = sum((V - E).^2)/n;

end