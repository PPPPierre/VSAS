function ValueH = I_Sphere_Single(VAR, INFO)

    fV     = VAR.fV1;
    Rm     = VAR.Rm1;
%     sigma  = VAR.sigma1 * abs(log(Rm));
    sigma  = VAR.sigma1;
    q      = INFO.Q;
    q      = reshape(q, length(q), 1);
    rho    = INFO.rho;
    
%% Distribution of R
    step   = 2000; 
    R      = linspace(200/step,200,step);
    H      = FunctionH(R, Rm, sigma);
    i      = INT_SINGLE_Sphere(q, R, rho);
    V      = VOLUME_Sphere(R);
    PART1  = (10.^fV)/trapz(R,H.*V,2);
    PART2  = trapz(R,H.*i,2);
    ValueH = PART1 * PART2;
    ValueH = ValueH';
end

function  i = INT_SINGLE_Sphere(q, R, rho)

    V   = VOLUME_Sphere(R);
    i   = (rho.*V.*FORM_FACTOR(q, R)).^2;
    
end

function ValueF = FORM_FACTOR(q, R)
    qR     = q*R;
    ValueF = 3 * ( (sin(qR)-qR.*cos(qR))./(qR).^3 );
end