function Final_report = OUTPUT_FINALREPORT(X_Best, SampleName, Total_time, Mean_time, fit_times, INFO)
    VariableNames   = X_Best.Properties.VariableNames;    
    X_Best_array    = table2array(X_Best); 
    ColumnNames     = [VariableNames 'Fit_Times' 'Total_Time' 'Mean_Time' 'Form_Type' 'Dis_Mode' 'Dis_Type'];
    X_Best_cell     = array2cell(X_Best_array);
    report_cell     = [X_Best_cell fit_times Total_time Mean_time {INFO.form_type} {INFO.dis_mode} {INFO.dis_type}];
    Final_report    = cell2table(report_cell, 'VariableNames', ColumnNames);
    Final_report.No = {SampleName(1:end-4)};
end