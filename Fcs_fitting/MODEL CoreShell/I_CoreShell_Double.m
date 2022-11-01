function I_Scattering = I_CoreShell_Double(VAR, INFO)

    VAR2       = VAR;
    VAR2.Rm1    = VAR2.Rm2;
    VAR2.sigma1 = VAR2.sigma2;
    VAR2.fV1    = VAR2.fV2;
    I_Scattering = I_CoreShell_Single(VAR, INFO) + I_CoreShell_Single(VAR2, INFO);
    
end