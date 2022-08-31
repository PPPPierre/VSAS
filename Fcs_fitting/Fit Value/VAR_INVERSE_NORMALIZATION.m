function VAR = VAR_INVERSE_NORMALIZATION(VAR_raw, INFO)
    VAR_raw_array = table2array(VAR_raw);
    VAR_array     = VAR_raw_array .* (INFO.ParRangeArray{1}(2,:)-INFO.ParRangeArray{1}(1,:)) + INFO.ParRangeArray{1}(1,:);
    VAR           = array2table(VAR_array,'VariableNames', INFO.VarNames);
end