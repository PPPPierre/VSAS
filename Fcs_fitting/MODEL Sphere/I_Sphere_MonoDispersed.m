function ValueI = I_Sphere_MonoDispersed(VAR, INFO)

    fV     = VAR.fV1;
    R      = VAR.Rm1;
    q      = INFO.Q;
    q      = reshape(q, length(q), 1);
    i      = INT_SINGLE_Sphere(q, R, INFO);
    V      = VOLUME_Sphere(R);
    PART1  = exp(fV)/R.*V;
    PART2  = i;
    ValueI = PART1 * PART2;
    ValueI = ValueI';

end

function  i = INT_SINGLE_Sphere(q, R, INFO)
    rho = INFO.rho;
    V   = VOLUME_Sphere(R);
    i   = (rho*V.*FORM_FACTOR(q, R)).^2;
end

function ValueF = FORM_FACTOR(q, R)
    qR     = q*R;
    ValueF = 3 * ( (sin(qR)-qR.*cos(qR))./(qR).^3 );
end