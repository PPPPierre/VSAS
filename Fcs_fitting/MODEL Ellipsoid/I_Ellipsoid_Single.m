function ValueH = I_Ellipsoid_Single(VAR, INFO)

    fV     = VAR.fV1;
    Rm     = VAR.Rm1;
    sigma  = VAR.sigma1 * abs(log(Rm));
    q      = INFO.Q;
    q      = reshape(q, length(q), 1);
    
    %% Distribution of R
        step   = 2000; 
        R      = linspace(200/step,200,step);
        H      = FunctionH(R, Rm, sigma);

        i      = INT_SINGLE_Ellipsoid(q, R, VAR, INFO);
        V      = VOLUME_Ellipsoid(R, VAR);
        PART1  = (10.^fV)/trapz(R,H.*V,2);
        PART2  = trapz(R,H.*i,2);
        ValueH = PART1 * PART2;
        ValueH = ValueH';
end

function  i = INT_SINGLE_Ellipsoid(q, R, VAR, INFO)
    rho  = INFO.rho;
    k    = VAR.k;
    V    = VOLUME_Ellipsoid(R, VAR);
    x    = 0:1/100:pi/2;
    x1   = reshape(x, 1,1,length(x));
    X    = (FORM_FACTOR(q,R.*sqrt(cos(x1).^2+k.^2.*sin(x1).^2))).^2.*cos(x1);
    F2   = trapz(x,X,3);
    i    = rho^2*(V.^2).*F2;
end

function ValueF = FORM_FACTOR(q, R)
    qR     = q.*R;
    ValueF = 3 * ( (sin(qR)-qR.*cos(qR))./(qR).^3 );
end