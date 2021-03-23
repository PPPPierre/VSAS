function GuinierOutputButtonCallback(~,~)
    global VSAS_main
    [File, Path]= uiputfile('*.txt', 'Save Data As');
    OutputInfo = strcat(Path, File);
    result = VSAS_main.guinier_result;
    fid = fopen(OutputInfo, 'W');
    %--------------------------------------------------导出参数
    fprintf(fid, '%s\t', 'Source File:');
    fprintf(fid, '%s', Path, File);
    fprintf(fid, '\r\n');
    fprintf(fid, '%s\t', 'qmin:');
    fprintf(fid, '%f\r\n', VSAS_main.guinier_para_qmin);
    fprintf(fid, '%s\t', 'qmax:');
    fprintf(fid, '%f\r\n', VSAS_main.guinier_para_qmax);
    fprintf(fid, '%s\t', 'Rg:');
    fprintf(fid, '%f\r\n', VSAS_main.guinier_para_Rg);
    fprintf(fid, '%s\t', 'Rsp:');
    fprintf(fid, '%f\r\n', VSAS_main.guinier_para_Rsp);
    %--------------------------------------------------导出拟合数据
    fprintf(fid, '%s\t', 'q');
    fprintf(fid, '%s\t', 'q^2');
    fprintf(fid, '%s\t', 'I(q)');
    for i = 1:1:size(result, 1)
        fprintf(fid, '\r\n');
        for j = 1:1:size(result, 2)
            fprintf(fid, '%f',result(i, j));
            fprintf(fid, '\t');
        end
    end
    fclose(fid);
end