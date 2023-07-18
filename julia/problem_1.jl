list = 1:999;
factor3 = list[list .% 3 .== 0];
factor5 = list[list .% 5 .== 0];
factor_list = [factor3..., factor5...];
total = sum(factor_list);
println(total)
