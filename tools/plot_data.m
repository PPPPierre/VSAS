% E = read_file();

% data_2_Iq = [data_2_1, data_2_2, data_2_3, data_2_4, data_2_5];
data_6_Iq = [d350_3_iq, d400_3_iq, d450_3_iq, d500_1_iq,d500_3_iq, d500_24_iq];
data_6_result = {
    d350_3, ...
    d400_3, ...
    d450_3, ...
    d500_1, ...
    d540_3, ...
    d540_24
};

data_iq = data_6_Iq;
result = data_6_result;

F = figure();
hold on

plot_sets(data_iq)

% 计算最佳拟合曲线
for i=1:size(result, 2)
    q = data_iq(i).data(:,1)';
    result_table = result{i};
    var = result_table.X_Best;
    FIT_INFO = result_table.FIT_INFO{1};

    var.Ibg = log(var.Ibg);
    var.sigma1 = log(var.sigma1);
    var.sigma2 = log(var.sigma2);
    var.fV1rho2 = log(var.fV1rho2);
    var.fV2rho2 = log(var.fV2rho2);

    I_Principle  = FIT_INFO.I_principle_func;
    I_Background = I_BG(var, FIT_INFO.INFO);
    I_Scattering = I_Principle(var, FIT_INFO.INFO);
    res          = I_Scattering + I_Background;
    res          = log10(res);
%     plot(log10(q), res, 'red', 'LineWidth', 1.5);
end

%% Visualisation
% text_data = {'300℃-1h', '350℃-1h', '425℃-1h', '425℃-3h', '475℃-1h', 'Fitting curve'};
text_data = {'350℃-3h', '400℃-3h', '450℃-3h', '500℃-1h', '540℃-3h','540℃-24h'};

lgd = legend(text_data);
lgd.FontSize = 12;

%% Set x ticks
x_tick_values = [0.001 0.01 0.1];
x_tick_n = size(x_tick_values, 2);
x_ticks = zeros(1, x_tick_n);
minor_values = [0.0002:0.0001:0.0009 0.002:0.001:0.009 0.02:0.01:0.09 0.2:0.1:0.9];
minor_size = size(minor_values);
for i=1:x_tick_n
    x_ticks(i) = log10(x_tick_values(i));
end
x_minor_ticks = zeros(1,minor_size(2));
for i=1:minor_size(2)
    x_minor_ticks(i) = log10(minor_values(i));
end
set(gca, 'xTickLabel',{'10^{-3}', '10^{-2}', '10^{-1}'})
set(gca, 'xTick', x_ticks);
hA = get(gca);
hA.XAxis.MinorTickValues = x_minor_ticks;

%% Set y yicks
y_tick_values = [-2 -1 0 1];
y_tick_n = size(y_tick_values, 2);
y_minor_values = [0.002:0.001:0.009 0.02:0.01:0.09 0.2:0.1:0.9 2:1:9 20:10:90];
y_minor_size = size(minor_values);
y_minor_ticks = zeros(1,y_minor_size(2));
for i=1:y_minor_size(2)
    y_minor_ticks(i) = log10(y_minor_values(i));
end
set(gca, 'yTickLabel',{'10^{-2}', '10^{-1}', '10^{0}', '10^{1}'})
set(gca, 'yTick', y_tick_values);
hA.YAxis.MinorTickValues = y_minor_ticks;

q = data_iq(1).data(:,1);
set(gca, 'XLim', [min(log10(q))-0.1 max(log10(q))+0.1]);
set(gca, 'FontSize', 15);
set(gca, 'GridLineStyle',':','GridColor','k','GridAlpha',0.3)
set(gca, ...
    'FontName', 'Times', ...
    'FontSize', 15, ...
    'FontWeight', 'bold',...
    'LineWidth', 1.5, ...
    'XMinorTick', 'on', ...
    'YMinorTick', 'on');
box(gca,'on');
grid on;
xlabel('$q(A^{-1})$', 'Interpreter', 'latex');
ylabel('$I(cm^{-1})$', 'Interpreter', 'latex');

function plot_sets(data_set)
    colors = {'#FD6D5A', '#FEB40B', '#6DC354', '#994487', '#518CD8', '#443295'};
    data_size = size(data_set, 2);
    for i = 1:data_size
        data = data_set(i).data;
        q = data(:,1);
        I = data(:,2);
        dI = data(:,3);
        n = size(q, 2);

        if min(I) > 0
            logI = log10(I);
        else
            logI = I;
            I = 10 .^ (logI);
        end
        
        rgb = Hex2RGB(colors{i});
        color = RGB2MatlabColor(rgb);

        dlogI = ones(n, 1) ./ I .* dI ./ log(10);
        errorbar(log10(q), ...
            logI, ...
            dlogI, ...
            '.-', ...
            'LineWidth', 1.2 ,...
            'CapSize', 15, ...
            'Color', color, ...
            'MarkerEdgeColor',color,...
            'MarkerFaceColor',color);
    end
end

function c = Hex2RGB(str)
    clist = '0123456789ABCDEF';
    nums = zeros(1, 6);
    for i = 1:6
        nums(i) = find(str(i + 1) == clist);
    end
    c = zeros(1, 3);
    for i = 1:3
        c(i) = 16 * (nums(2*i-1) - 1) + (nums(2*i) - 1);
    end
end

function c = RGB2MatlabColor(rgb)
    c = round(100 * rgb/255) / 100;
end