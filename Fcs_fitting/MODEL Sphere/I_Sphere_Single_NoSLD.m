function ValueH = I_Sphere_Single_NoSLD(VAR, INFO)

    fVrho2 = exp(VAR.fV1rho2);
    Rm     = VAR.Rm1;
    sigma  = VAR.sigma1 * abs(log(Rm));
    sigma  = exp(VAR.sigma1);
%     sigma  = VAR.sigma1;
    
    %% Distribution of R
    R      = INFO.R;
    H      = FunctionH(R, Rm, sigma);
    i      = INFO.i{1};
    V      = INFO.V;
    PART1  = fVrho2./trapz(R,H.*V,2);
    PART2  = trapz(R,H.*i,2);
    ValueH = PART1 * PART2;
    ValueH = ValueH';
end