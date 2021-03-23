function DRAW_R_DISS(File_name, Sample_num, Save_Path)
%% LOAD DATA 数据载入
    data_range        = ['B2:G', num2str(Sample_num + 1)];
    [data, text_data] = xlsread(File_name, 'sheet1', data_range);

%% EXTRACT DATA 数据提取
    fV     = data(:,3);
    Rm     = data(:,1); 
    sigma  = data(:,2);
    fV2    = data(:,6);
    Rm2    = data(:,4);
    sigma2 = data(:,5);

%% CALCULATE DISSTRIBUTION 分布计算
    num    = size(data,1);
    range  = 20;
    step   = 2000;
    diss_R = zeros(num, step);
    R      = linspace(range/step,range,step);

    %% LogNorm
    for i = 1:num
        diss_R(i,:) = lognpdf(R, log(Rm(i)), sigma(i)) .* fV(i) + ...
             lognpdf(R, log(Rm2(i)), sigma2(i)) .* fV2(i);
    end

    %% Norm
%     for i = 1:num
%         diss_R(i,:) = lognpdf(R, log(Rm(i)), sigma(i)) .* fV(i) + ...
%              lognpdf(R, log(Rm2(i)), sigma2(i)) .* fV2(i);
%     end

%% Visualisation
    F     = figure('visible', 'off');
    hold on;
    for i = 1:num
        plot(R,diss_R(i,:),'LineWidth',1);
    end
    legend (text_data);
    title('Distribution of R');
    xlabel('R(nm)');
    ylabel('h(R)*fV*100');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10]);
    saveas(F, [Save_Path, 'R_diss'], 'jpg');
    close;
end