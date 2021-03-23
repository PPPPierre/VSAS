%菜单项"VSAS"返回函数：新建窗口
function copyright(~,~)
    mb = msgbox({'VSAS is a Visual Small-angle X-Ray / neutron scattering fitting software'
        'developed by Zhong et al. of Shanghai Jiao Tong University. This tool  '
        'can help you to analyze size distribution, volume fraction etc. with form '
        'hypothesis of particles in samples from small-angle scattering data. '
        '  '
        'More details, help files, publications, latest version and copyright, please visit our home page of VSAS.'
        'http://cc.sjtu.edu.cn/G2S/Template/View.aspx?courseId = 8197&topMenuId'
        '= 133595&action = view&type =&name =&menuType = 1'}, 'About VSAS');
    text = findobj(mb);
    set(text(1), 'position', [500 250 350 218]);
    set(text(2), 'position', [270 15 50 30], 'String', 'I know', 'Fontname', 'Times New Roman', 'FontSize', 10);
    set(text(4), 'Position', [15 77 50], 'FontSize', 10, 'FontName', 'Times New Roman');
    Info = uicontrol('Parent', mb, 'Style', 'Pushbutton', 'String', 'To VSAS HomePage', 'Fontname', 'Times New Roman', 'foregroundColor', 'red', 'Callback', @Web, 'FontSize', 10);
    set(Info, 'Position', [22 23 125 38], 'HorizontalAlignment', 'Left');
end

% 打开网址
function Web(~,~)
    URL = 'http://cc.sjtu.edu.cn/G2S/Template/View.aspx?courseId = 8197&topMenuId = 133595&action = view&type =&name =&menuType = 1';
    web(URL);
end