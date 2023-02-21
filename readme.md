# VSAS introduction v 1.2
This is an algorithm used for small-angle scattering data analysis.
It contains two modes: Guinier approach mode and Distribution fitting mode:
- Guinier approach mode: using triditional Guinier aproche or Porod method to determine the pamameters of the model.
- Distribution Fitting mode: fit the parameters of model based on optimization methods.

## Introduction fo Folders
- @FIT_INFO @VSAS_MAIN
Folder @FIT_INFO and @VSAS_MAIN contains two class of the algorithm
@VSAS_MAIN ins the main class of the whole algorithm
@FIT_INFO used for storing the hyper-parameters and data structures needed by Distribution Fitting mode
- Fcs_fittin
Contains all functions related Distribution Fitting mode
- Fcs_UI
Contains all functions related to UI
- files
Contains some necessary data files and images

## Instuctions of the VSAS
1. add the path of the folder to Matlab
2. run main.m
3. choose the mode
4. load the experimental data
5. analyzing

## Settings - distribution fitting mode

1. Loss function choose

The loss function for the Baysian optimization and the gradient descending module can be chosen from Chi2 and MSE loss. The popmenu is shown as the following picture.

![image](https://github.com/PPPPierre/VSAS/blob/main/imgs/Loss_function_choose.jpg)

The fomulas for two loss functions are shown as below.

![image](https://github.com/PPPPierre/VSAS/blob/main/imgs/loss_functions.jpg)

2. Generate distribution visualization with incertitude

Now the output contains a figure for showing the distribution of particle size with incertitude, which gives the result summarized from all **valid fitting results**. The threshold for defining **valid fitting result** is shown as the following picture.

![image](https://github.com/PPPPierre/VSAS/blob/main/imgs/Loss_threshold.jpg)

- For Chi2 loss, we recommand to set the threshold between 1 and 10.

- For MSE loss, we recommand to set the threshold between 0.1 and 0.01.

## Update log
2022/08/31 Version: 1.2

- Added distribution visualization output with incertitude for distribution fitting mode.

- Output more details in the Report.xls file for distribution fitting mode.

- Add loss function option for Baysian optimization and Gradient descent module. Chi2 and MSE are currently supported.

2021/12/20 Version: 1.1
- Fix a bug that makes the fitting program on the CoreShell model under Distribution fitting model not work.

2021/12/15 Version: 1.0
- Release VSAS 1.0

2021/7/16
- For all three forms, the way to fit sigma is to fit the value of sigma/|log(Rm)|
- For sphere form, now the parameter fv¦¤¦Ñ^2 is fitted with its order, which means we fit log(fv¦¤¦Ñ^2)

## Contact
Any bug or problem please contact:
SHI Shuxin 
email: ssxhcxr4691059@163.com
