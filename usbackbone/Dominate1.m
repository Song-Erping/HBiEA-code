function apflag = Dominate1(temp_one,temp_two)
temp1 = all(temp_one <= temp_two,2);
temp2 = all(temp_two <= temp_one,2);
% apflag = temp1.*temp2 + temp1-temp2;
apflag = temp1-temp2;
end

