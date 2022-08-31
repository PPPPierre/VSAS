function I_Scattering = I_Ellipsoid_Double(VAR, INFO)

    VAR2       = VAR;
    VAR2.Rm    = VAR2.Rm2;
    VAR2.sigma = VAR2.sigma2;
    VAR2.fV    = VAR2.fV2;
    I_Scattering = I_Ellipsoid_Single(VAR, INFO) + I_Ellipsoid_Single(VAR2, INFO);
    
end