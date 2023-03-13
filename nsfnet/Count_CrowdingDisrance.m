function Serial_Num = Count_CrowdingDisrance(Data_Value,Obj_Num,maxSerial_Num)

temp_num = numel(Data_Value(:,1));
xtemp_num = temp_num-1;
CD_Value = zeros(temp_num,1);
temp_CD_Value = zeros(temp_num,1);
for u = 1:Obj_Num
    [temp_Value,temp_Pos] = sort(Data_Value(:,u));
    temp_Value = (temp_Value-min(temp_Value))/(max(temp_Value)-min(temp_Value));
    temp_CD_Value(1) = inf;
    temp_CD_Value(temp_num) = inf;
    for k = 2:xtemp_num
        temp_CD_Value(k) = abs(temp_Value(k+1)-temp_Value(k-1));
    end
    CD_Value(temp_Pos) = CD_Value(temp_Pos)+temp_CD_Value;
end
[~,Serial_Num] = sort(CD_Value,'descend');
Serial_Num = Serial_Num+maxSerial_Num;