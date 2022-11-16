function ValueH = I_Sphere_Single(VAR, INFO)

    fV     = 10 .^ VAR.fV1;
    Rm     = VAR.Rm1;
%     sigma  = VAR.sigma1 * abs(log(Rm));
    sigma  = VAR.sigma1;
    rho    = INFO.rho;
    
%% Distribution of R
    R      = INFO.R;
    H      = FunctionH(R, Rm, sigma);
    i      = INFO.i{1} .* (rho ^ 2);
    V      = INFO.V;
    PART1  = fV/trapz(R,H.*V,2);
    PART2  = trapz(R,H.*i,2);
    ValueH = PART1 * PART2;
    ValueH = ValueH';
end