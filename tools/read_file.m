function E = read_file()
    [file_name, file_path] = uigetfile('*.txt', 'Select data file');
    if file_path ~= 0
        data_file = strcat(file_path, file_name);
        E = importdata(data_file);
    end
end