function ValueI = I_CoreShell_Single(VAR, INFO)

    fV     = VAR.fV1;
    Rm     = VAR.Rm1;
    sigma  = VAR.sigma1;
    q      = INFO.Q;
    q      = reshape(q, length(q), 1);
    
    %% Distribution of R
    step   = 1000;
    R      = linspace(100/step,100,step);
    H      = FunctionH(R, Rm, sigma);
    
    i      = INT_SINGLE_CoreShell(q, R, VAR, INFO);
    V      = VOLUME_CoreShell(R);
    PART1  = exp(fV)/trapz(R,H.*V,2);
    PART2  = trapz(R,H.*i,2);
    ValueI = PART1 * PART2;
    ValueI = ValueI';
    
end

function  i = INT_SINGLE_CoreShell(q, R, VAR, INFO)
    rho = INFO.rho;
    nu  = VAR.nu;
    x   = VAR.x;
    num = round(x/0.001);
    mu  = INFO.material(num+1);
    V   = VOLUME_Sphere(R);
    V2  = VOLUME_Sphere(nu*R);
    i   = (mu*rho*V.*FORM_FACTOR(q, R) + (1-mu)*rho*V2.*FORM_FACTOR(q, nu*R)).^2;
end

function ValueF = FORM_FACTOR(q, R)
    qR     = q*R;
    ValueF = 3 * ( (sin(qR)-qR.*cos(qR))./(qR).^3 );
end