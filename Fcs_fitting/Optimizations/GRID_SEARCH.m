function pointBest = GRID_SEARCH(x_center, INFO, loss_func)

    lay       = INFO.GS_point_range;
    Vic       = GET_VICINITY(x_center, 0.001, lay);
    min_range = max(Vic(1,:), INFO.ParRangeArray{1}(1,:));
    max_range = min(Vic(end,:), INFO.ParRangeArray{1}(2,:));
    
    switch INFO.GS_search_mode
        case 'Random'
            Point_num       = INFO.GS_point_number;
            Point_list      = zeros(Point_num + 1, INFO.ParNum);
            loss_list       = zeros(1, Point_num + 1);
            Point_list(1,:) = table2array(x_center);
            loss_list(1)    = LOSS_VALUE(Point_list(1,:), INFO, loss_func);
            for i = 1:Point_num
                point             = unifrnd(min_range,max_range);
                loss_list(i+1)    = LOSS_VALUE(point, INFO, loss_func);
                Point_list(i+1,:) = point;
            end
        otherwise
            Point_list = GRID2VEC(Vic);
            Point_num  = size(Point_list,1);
            loss_list  = zeros(1, Point_num);
            for i = 1:Point_num
                loss_list(i) = LOSS_VALUE(Point_list(i, :), INFO, loss_func);
            end
    end
    pointBest = ARRAY2TABLE(Point_list(loss_list == min(loss_list), :), INFO);
    
end