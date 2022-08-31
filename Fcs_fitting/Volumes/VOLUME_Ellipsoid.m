function  ValueV = VOLUME_Ellipsoid(R,VAR)
    k = VAR.k;
    ValueV = 4/3*pi*(R.^3)*k;
end