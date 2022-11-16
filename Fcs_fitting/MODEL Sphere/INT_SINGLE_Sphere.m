function  i = INT_SINGLE_Sphere(q, R)
    V   = VOLUME_Sphere(R);
    i   = (V.*FORM_FACTOR_sphere(q, R)).^2;
end