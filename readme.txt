【VSAS introduction】v 1.0
This is an algorithm used for analyzing the data of small-angle scattering.
It contains two modes: Guinier mode and Distribution fitting mode:
Guinier mode: using triditional Guinier aproche or Porod method to determine the pamameters of model.
Distribution Fitting: by using optimization method to get the parameters of model.

【Introduction fo Folders】
—— @FIT_INFO @VSAS_MAIN ——
Folder @FIT_INFO and @VSAS_MAIN contains two class of the algorithm
@VSAS_MAIN ins the main class of the whole algorithm
@FIT_INFO used for storing the hyper-parameters and data structures needed by Distribution Fitting mode
—— Fcs_fittin ——
Contains all functions related Distribution Fitting mode
—— Fcs_UI——
Contains all functions related to UI
—— files ——
Contains some necessary data files and images

【Instuctions of the VSAS】
1. add the path of the folder to Matlab
2. run main.m
3. choose the mode
4. read the experimental data
5. analyzing

【Update log】
2021/7/16
1. For all three forms, the way to fit sigma is to fit the value of sigma/|log(Rm)|
2. For sphere form, now the parameter fvΔρ^2 is fitted with its order, which means we fit log( fvΔρ^2)

If there is any bug or problem please contact:
石书欣 Shuxin SHI 
email: ssxhcxr4691059@163.com