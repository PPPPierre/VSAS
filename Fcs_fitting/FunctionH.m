function  ValueH = FunctionH(R, Rm, sigma)

    ValueH = lognpdf(R, log(Rm), sigma);

end