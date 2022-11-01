function I_Scattering = I_CoreShell_Double_NoSLD(VAR, INFO)

    VAR2       = VAR;
    VAR2.Rm1    = VAR2.Rm2;
    VAR2.sigma1 = VAR2.sigma2;
    VAR2.fV1rho2    = VAR2.fV2rho2;
    I_Scattering = I_CoreShell_Single_NoSLD(VAR, INFO) + I_CoreShell_Single_NoSLD(VAR2, INFO);
    
end