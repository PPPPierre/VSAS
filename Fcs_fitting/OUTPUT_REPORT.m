function User_report = OUTPUT_REPORT(Best_No, XB, Chi2, CorM, Max_Patch, P_Value, INFO)
    Log_Variables = INFO.Log_VarNames;
    VariableNames = XB.Properties.VariableNames;
    XB_array      = table2array(XB); 
    row_num       = size(XB,1);
    range_array   = INFO.ParRangeArray{1};
    fitNo_array   = zeros(row_num,1);
    
    %% 参数逆归一化
    for i = 1:row_num
        XB_array(i,:)    = XB_array(i,:).*(range_array(2,:) - range_array(1,:)) + range_array(1,:); 
        fitNo_array(i,1) = i;
    end 
    
    %% 将log过的参数恢复
    for i = 1:length(VariableNames)
        if ismember(VariableNames{i}, Log_Variables)
            XB_array(:,i) = 10.^XB_array(:,i);
        end
    end
    
    ColumnNames  = ['No' INFO.VarNames 'Chi2' 'CorMap' 'MaxPatch' 'PValue'];
    report_array = [fitNo_array XB_array Chi2(3,:)' CorM(3,:)' Max_Patch' P_Value'];
    User_report  = array2table(report_array, 'VariableNames', ColumnNames);
    color        = [1, 0, 1];
    cprintf(color, strcat('The best fitting is No.', num2str(Best_No), '\n'));
end