【VSAS 软件介绍】v 1.0
这是一款可用于小角散射数据分析的软件，
其中包含Guinier模式和Distribution Fitting两个模式：
Guinier模式：通过传统Guinier渐进/Porod渐进等方法确认样品的参数
Distribution Fitting：通过最优化模型拟合的方法确定样品参数

【文件夹介绍】
—— @FIT_INFO @VSAS_MAIN ——
文件夹@FIT_INFO与@VSAS_MAIN是程序相关的两个类的文件
其中@VSAS_MAIN是整个程序的主要调用的类
@FIT_INFO则是存储Distribution Fitting模式需要使用的参数的数据结构
—— Fcs_fitting文件夹 ——
包含所有Distribution Fitting相关函数
—— Fcs_UI文件夹 ——
包含所有与UI界面相关的函数
—— files文件夹 ——
包含需要的一些数据文件以及图片

【程序使用指南】
1. 将文件夹路径添加至matlab中
2. 运行主程序main.m
3. 选择模式
4. 读取实验数据
5. 进行拟合或数据分析

有任何bug或问题请联系本人
邮箱：ssxhcxr4691059@163.com

石书欣 上海交通大学