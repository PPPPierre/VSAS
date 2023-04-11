%% LOAD DATA
% data_1_80 = {
%     d801.report{1}, ...
%     d802.report{1}, ...
%     d803.report{1}, ...
%     d804.report{1}
%     };
% data_1_82 = {
%     d821.report{1}, ...
%     d822.report{1}, ...
%     d823.report{1}, ...
%     d824.report{1}
%     };
% data_1_83 = {
%     d831.report{1}, ...
%     d832.report{1}, ...
%     d833.report{1}, ...
%     d834.report{1}
%     };
% data_2_chi2_fix = {
%     d300_1h, ...
%     d350_1h, ...
%     d425_1h, ...
%     d425_3h, ...
%     d475_1h
%     };
% data_3 = {
%     Y3.report{1}, ...
%     Y4.report{1}, ...
%     Y5.report{1}, ...
%     Z1.report{1}, ...
%     Z3.report{1}, ...
%     Z4.report{1}, ...
%     Z5.report{1}, ...
%     };
% data_4 = {
%     CP.report{1}, ...
%     HE.report{1}, ...
%     HS.report{1}, ...
%     LS.report{1}, ...
%     Rc.report{1}, ...
%     Ref.report{1}
%     };
% data_6 = {
%     d350_3.report{1}, ...
%     d400_3.report{1}, ...
%     d450_3.report{1}, ...
%     d500_1.report{1}, ...
%     d540_3.report{1}, ...
%     d540_24.report{1}
% };

data = data_6;
R_min = 0;
R_max = 2;
I_min = -0.3;
I_max = 1;
valid_loss = 1.4;
% loss = 'MSE';
loss = 'Chi2';

% lgd_data = {'300℃-1h', '350℃-1h', '425℃-1h', '425℃-3h', '475℃-1h'};
% lgd_data = {'Y3', 'Y4', 'Y5', 'Z1', 'Z3', 'Z4', 'Z5'};
% lgd_data = {'80-1', '80-2', '80-3', '80-4'};
% lgd_data = {'82-1', '82-2', '82-3', '82-4'};
% lgd_data = {'83-1', '83-2', '83-3', '83-4'};
% lgd_data = {'CP', 'HE', 'HS', 'LS', 'Rc', 'Ref'};
lgd_data = {'350℃-3h', '400℃-3h', '450℃-3h', '500℃-1h', '540℃-3h', '540℃-24h'};

colors = {'#FD6D5A', '#FEB40B', '#6DC354', '#994487', '#518CD8', '#443295', '#2A9D8F'};

%% Get variable position
col_names = data{1}.Properties.VariableNames;
pos_chi2 = ismember(col_names, loss);
pos_Rm1 = ismember(col_names, 'Rm1');
pos_sigma1 = ismember(col_names, 'sigma1');
pos_fv1 = ismember(col_names, 'fV1rho2');

pos_Rm2 = ismember(col_names, 'Rm2');
if sum(pos_Rm2) > 0
    pos_sigma2 = ismember(col_names, 'sigma2');
    pos_fv2 = ismember(col_names, 'fV2rho2');
end

pos_nu1 = ismember(col_names, 'nu');
if sum(pos_nu1) > 0
    pos_nu2 = ismember(col_names, 'nu2');
    pos_x1 = ismember(col_names, 'x');
    pos_x2 = ismember(col_names, 'x2');
end

%% CALCULATE DISSTRIBUTION
batch  = size(data, 2);
step   = 1000;
R      = linspace(R_min, R_max, step);

F = figure();
hold on;

lines = [];

output_mean = zeros(batch, size(data{1}, 2));
output_std = zeros(batch, size(data{1}, 2));

for i = 1:batch
    
    report_array = table2array(data{i});
    valid_array = report_array(report_array(:, pos_chi2) < valid_loss,:);
    num = size(valid_array, 1);
    diss_R = zeros(num, step);
    
    for j = 1:num
        Rm1 = valid_array(j, pos_Rm1);
        Rm2 = valid_array(j, pos_Rm2);
        sigma1 = valid_array(j, pos_sigma1);
        sigma2 = valid_array(j, pos_sigma2);
        fv1 = valid_array(j, pos_fv1);
        fv2 = valid_array(j, pos_fv2);
        diss_R(j,:) = ...
            lognpdf(10.^(R), log(Rm1), sigma1) .* exp(fv1) + ...
            lognpdf(10.^(R), log(Rm2), sigma2) .* exp(fv2);
        
        if sum(pos_nu1) > 0
            nu1 = valid_array(j, pos_nu1);
            nu2 = valid_array(j, pos_nu2);
            x1 = valid_array(j, pos_x1);
            x2 = valid_array(j, pos_x2);
        end
        
        if Rm1 > Rm2 
            valid_array(j, pos_Rm2) = Rm1;
            valid_array(j, pos_fv2) = fv1;
            valid_array(j, pos_sigma2) = sigma1;
            valid_array(j, pos_Rm1) = Rm2;
            valid_array(j, pos_fv1) = fv2;
            valid_array(j, pos_sigma1) = sigma2;
            valid_array(j, pos_nu1) = nu2;
            valid_array(j, pos_nu2) = nu1;
            valid_array(j, pos_x1) = x2;
            valid_array(j, pos_x2) = x1;
        end
    end
    
    rgb = Hex2RGB(colors{i});
    color = RGB2MatlabColor(rgb);
    
    if size(valid_array, 1) > 1
        output_mean(i, :) = mean(valid_array);
        output_std(i, :) = std(valid_array);
    elseif size(valid_array, 1) == 1
        output_mean(i, :) = valid_array;
        output_std(i, :) = zeros(1, size(valid_array, 2));
    end
    
    dis_mean = mean(diss_R, 1);
    dis_std = std(diss_R, 1);
    dis_up = dis_mean + dis_std;
    dis_down = dis_mean - dis_std;
    line = plot(R, dis_mean, 'LineWidth', 1.5, 'Color', color);
    lines = [lines line];
    fill_part = fill([R, fliplr(R)], [dis_down, fliplr(dis_up)], color);
    set(fill_part, 'edgealpha', 0, 'facealpha', 0.3)
    
end

table_mean = array2table(output_mean, 'VariableNames', col_names);
table_std = array2table(output_std, 'VariableNames', col_names);

%% Visualisation
lgd = legend(lines, lgd_data);
lgd.FontSize = 12;

x_ticks = zeros(1,2);
x_tick_values = [0.1 1 10];
minor_values = [0.1:0.1:0.9 2:1:9 20:10:90];
minor_size = size(minor_values);

for i=1:size(x_tick_values, 2)
    x_ticks(i) = log10(x_tick_values(i));
end

x_minor_ticks = zeros(1,minor_size(2));

for i=1:minor_size(2)
    x_minor_ticks(i) = log10(minor_values(i));
end

set(gca, 'xTick', x_ticks);

hA = get(gca);
hA.XAxis.MinorTickValues = x_minor_ticks;
set(gca, 'xTickLabel',{'10^{-1}', '10^{0}', '10^{1}'})

set(gca, 'XLim', [R_min R_max]);
% set(gca, 'YLim', [I_min I_max]);
xlabel('R(nm)', 'Interpreter', 'latex');
ylabel('$f_{V} \Delta \rho ^{2}$', 'Interpreter', 'latex');

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
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10]);
% saveas(F, [Save_Path, 'R_diss'], 'jpg');
% close;

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