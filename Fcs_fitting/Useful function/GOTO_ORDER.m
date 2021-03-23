function res = GOTO_ORDER(x, order)
ordx = GET_ORDER(x);
res = x.*10.^(order - ordx);
end