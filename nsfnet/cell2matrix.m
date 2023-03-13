function Pop_Rout_lower=cell2matrix(Pop_Rout_lower)
num=0;
for i=1:size(Pop_Rout_lower,2)
    rout=Pop_Rout_lower{1,i};
    for j=1:size(rout,2)
         num=num+1;
         tempRout_lower(:,num)=rout(:,j);
    end
end
Pop_Rout_lower=tempRout_lower;