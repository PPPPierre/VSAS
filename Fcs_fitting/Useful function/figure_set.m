function figure_set(x_label, y_label, tit, XYlim)
set(gca, 'Fontname', 'Computer Modern', 'FontSize',13);
xlabel(x_label, 'Interpreter','latex');
ylabel(y_label, 'Interpreter', 'latex');
title(tit, 'Interpreter', 'latex');

if nargin == 4
    axis(XYlim);
%     set(gca,'axis', XYlim);
end

end

