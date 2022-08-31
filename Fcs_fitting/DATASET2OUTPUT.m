function [best_num,Output] = DATASET2OUTPUT(data_set, INFO)
best_num          = find(data_set(:,end)==min(data_set(:,end)));
if size(best_num, 1) > 1
    best_num = best_num(1);
end
best_result       = data_set(best_num,:);
% data_mean         = mean(data_set);
% data_std          = std(data_set);
VarNames          = INFO.VarNames;
VarNames(end + 1) = {'Loss'};
Output            = array2table(best_result,'VariableNames', VarNames);
end