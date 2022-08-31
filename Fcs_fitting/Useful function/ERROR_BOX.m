function ERROR_BOX(message)
img = imread('Error_icon.png');
CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';
mes = strcat('\fontsize{12} \fontname{Sylfaen}', 32, message);
msgbox(mes,'Error','custom',img,[],CreateStruct);

end