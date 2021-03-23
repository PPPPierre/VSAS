function Vec = GRID2VEC(Grid)
m = size(Grid, 1);
n = size(Grid, 2);
ind=fullfact(m*ones(1, n));
Vec = [];
for i = 1:n
    V = Grid(:, i);
    Vec = [Vec reshape(V(ind(:,i)),[],1)];
end
end