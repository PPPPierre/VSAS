% E = read_file();
% data = E.data;

F = figure();
hold on 

q = data(:,1);
I = data(:,2);
if size(data, 2) > 2
    dI = data(:,3);
else
    dI = ones(size(data, 1), 1);
end
n = size(q, 2);

if min(I) > 0
    logI = log(I);
else
    logI = I;
    I = exp(logI);
end

dlogI = ones(n, 1) ./ I .* dI;
if size(data, 2) > 2
    errorbar(log10(q), ...
        logI, ...
        dlogI, ...
        '.-', ...
        'LineWidth', 1.2 ,...
        'CapSize', 10, ...
        'Color', 'black', ...
        'MarkerEdgeColor', 'black',...
        'MarkerFaceColor', 'black');
else
    plot(log10(q), logI, '*', 'Color', 'black');
end

%% CALCULATE DISSTRIBUTION
XB = result_table.XB{1};
FIT_INFO = result_table.FIT_INFO{1};
num = size(XB, 1);
I_Principle  = FIT_INFO.I_principle_func;

chi2_sum = 0;

report = result_table.report{1};
col_names = report.Properties.VariableNames;
pos_chi2 = ismember(col_names, 'Chi2');
report_array = table2array(report);

% Plot X best
var = XB(result_table.Best_num,:);
I_Background = I_BG(var, FIT_INFO.INFO);
I_Scattering = I_Principle(var, FIT_INFO.INFO);
res          = I_Scattering + I_Background;
res          = log(res);
plot(log10(q), res, 'r', 'LineWidth', 1.5);

% calculate chi2
for i=1:num
    var = XB(i,:);
    I_Background = I_BG(var, FIT_INFO.INFO);
    I_Scattering = I_Principle(var, FIT_INFO.INFO);
    res          = I_Scattering + I_Background;
    res          = log(res);
%     plot(log(q), res);
    chi2 = get_Chi2(res, logI', dlogI');
    report_array(i,pos_chi2) = chi2;
end

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

%% Set x ticks
x_tick_values = [0.1 1 10];
x_tick_n = size(x_tick_values, 2);
x_ticks = zeros(1, x_tick_n);
minor_values = [0.02:0.01:0.09 0.2:0.1:0.9 2:1:9 20:10:90];
minor_size = size(minor_values);
for i=1:x_tick_n
    x_ticks(i) = log10(x_tick_values(i));
end
x_minor_ticks = zeros(1,minor_size(2));
for i=1:minor_size(2)
    x_minor_ticks(i) = log10(minor_values(i));
end
set(gca, 'xTickLabel',{'10^{-1}', '10^{0}', '10^{1}'})
set(gca, 'xTick', x_ticks);
hA = get(gca);
hA.XAxis.MinorTickValues = x_minor_ticks;

%% Set y yicks
y_tick_values = [log(0.01) log(0.1) log(1) log(10) log(100) log(1000)];
y_tick_n = size(y_tick_values, 2);
y_minor_values = [0.002:0.001:0.009 0.02:0.01:0.09 0.2:0.1:0.9 2:1:9 20:10:90 200:100:900 2000:1000:9000];
y_minor_size = size(y_minor_values, 2);
y_minor_ticks = zeros(1,y_minor_size);
for i=1:y_minor_size
    y_minor_ticks(i) = log(y_minor_values(i));
end
set(gca, 'yTickLabel',{'10^{-2}', '10^{-1}', '10^{0}', '10^{1}', '10^{2}', '10^{3}'})
set(gca, 'yTick', y_tick_values);
hA.YAxis.MinorTickValues = y_minor_ticks;

report_table = array2table(report_array, 'VariableNames', col_names);

function E = read_file()
    [file_name, file_path] = uigetfile('*.txt', 'Select data file');
    if file_path ~= 0
        data_file = strcat(file_path, file_name);
        E = importdata(data_file);
    end
end

function res = get_Chi2(I_simu, I_exp, dlogI)

    n   = length(I_simu);
    res = sum(((I_simu - I_exp) ./ dlogI).^2)/(n-2);

end