function data_reduce = REDUCE_DATA (Data_raw, scale)

    data_size = size(Data_raw);
    data_size(1) = floor(data_size(1)/scale);
    data_reduce = zeros(data_size);
    for i = 1:data_size(1)
        data_reduce(i,:) = Data_raw(2*i, :);
    end
    
end