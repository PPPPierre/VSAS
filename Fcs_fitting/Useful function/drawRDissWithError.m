function drawRDissWithError(valid_array, Save_Path, R_max)
%% LOAD DATA 数据载入
    num = size(valid_array, 1);
    if(~exist('R_max','var'))
        R_max = 20;  % 如果未出现该变量，则对其进行赋值
    end

%% EXTRACT DATA 数据提取
    Rm     = valid_array(:,1); 
    sigma  = valid_array(:,2);
    fV     = valid_array(:,3);
    Rm2    = valid_array(:,4);
    sigma2 = valid_array(:,5);
    fV2    = valid_array(:,6);

%% CALCULATE DISSTRIBUTION 分布计算
    range  = R_max;
    step   = R_max * 100;
    diss_R = zeros(num, step);
    R      = linspace(range/step,range,step);

    %% LogNorm
    for i = 1:num
        diss_R(i,:) = lognpdf(R, log(Rm(i)), sigma(i)) .* (10 ^ fV(i)) + ...
             lognpdf(R, log(Rm2(i)), sigma2(i)) .* (10 ^ fV2(i));
    end
    
    dis_mean = mean(diss_R, 1);
    dis_std = std(diss_R, 1);

    %% Norm
%     for i = 1:num
%         diss_R(i,:) = lognpdf(R, log(Rm(i)), sigma(i)) .* fV(i) + ...
%              lognpdf(R, log(Rm2(i)), sigma2(i)) .* fV2(i);
%     end

%% Visualisation
    F     = figure('visible', 'off');
    hold on;
    dis_up = dis_mean + dis_std;
    dis_down = dis_mean - dis_std;
    plot(R, dis_mean, 'LineWidth', 1);
    fill_part = fill([R, fliplr(R)], [dis_down, fliplr(dis_up)], 'r');
    set(fill_part, 'edgealpha', 0, 'facealpha', 0.3)
%     legend (text_data);
    title('Distribution of R');
    xlabel('R(nm)');
    ylabel('h(R)*fV*100');
    grid on;
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10]);
    saveas(F, [Save_Path, 'R_diss_with_error'], 'jpg');
    close;
end