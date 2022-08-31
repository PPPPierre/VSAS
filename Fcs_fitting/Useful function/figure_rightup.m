function [] = figure_rightup()
pos=get(0,'screensize');
width = 550; height = 400;
set(gcf,'position',[pos(3)-width pos(4)-height-80  width  height]);
end
