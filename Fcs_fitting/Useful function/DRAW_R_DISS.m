function DRAW_R_DISS(File_name, Sample_num, Save_Path, R_max)
%% LOAD DATA ��������
    data_range        = ['B2:G', num2str(Sample_num + 1)];
    [data, text_data] = xlsread(File_name, 'sheet1', data_range);
    if(~exist('R_max','var'))
        R_max = 20;  % ���δ���ָñ������������и�ֵ
    end

%% EXTRACT DATA ������ȡ
    Rm     = data(:,1); 
    sigma  = data(:,2);
    fV     = data(:,3);
    Rm2    = data(:,4);
    sigma2 = data(:,5);
    fV2    = data(:,6);

%% CALCULATE DISSTRIBUTION �ֲ�����
    num    = size(data,1);
    range  = R_max;
    step   = R_max * 100;
    diss_R = zeros(num, step);
    R      = linspace(range/step,range,step);

    %% LogNorm
    for i = 1:num
        diss_R(i,:) = lognpdf(R, log(Rm(i)), sigma(i)) .* (10 ^ fV(i)) + ...
             lognpdf(R, log(Rm2(i)), sigma2(i)) .* (10 ^ fV2(i));
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
    grid on;
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10]);
    saveas(F, [Save_Path, 'R_diss'], 'jpg');
    close;
end