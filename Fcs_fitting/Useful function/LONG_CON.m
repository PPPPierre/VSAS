function num = LONG_CON(x, value)
t = round(x) == value;
num = max(find(diff([t false])==-1)-find(diff([false t])==1)+1);
end

