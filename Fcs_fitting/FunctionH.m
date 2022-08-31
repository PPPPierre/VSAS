function  ValueH = FunctionH(R, Rm, sigma)

    ValueH = lognpdf(R, log(Rm), sigma);
%     ValueH = normpdf(R, Rm, sigma);

end