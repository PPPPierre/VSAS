function I_Scattering = I_Sphere_Double(VAR, INFO)

    VAR2        = VAR;
    VAR2.Rm1    = VAR2.Rm2;
    VAR2.sigma1 = VAR2.sigma2;
    VAR2.fV1    = VAR2.fV2;
    I_Scattering = I_Sphere_Single(VAR, INFO) + I_Sphere_Single(VAR2, INFO);
    
end