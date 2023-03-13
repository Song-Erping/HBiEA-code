function [bestPop_DC_lower bestPop_Rout_lower]=unique_struct(Pop_DC_lower,Pop_Rout_lower)

bestPop=[Pop_DC_lower' Pop_Rout_lower']';
flag_arr=zeros(1, size(bestPop,2));
for i=1:size(bestPop,2)
    for j=i+1:size(bestPop,2)
        if flag_arr(i)==0
            flag=(sum(bestPop(:,i)==bestPop(:,j))==size(bestPop,1));
            if flag==1
               flag_arr(j)=1;
            end
        end
    end
end
pos=find(flag_arr==0);
bestPop=bestPop(:,pos);

bestPop_DC_lower=bestPop(1:size(Pop_DC_lower,1),:);
Pop_Rout_lower=bestPop(size(Pop_DC_lower,1)+1:end,:);

for k=1:size(bestPop,2)
    bestPop_Rout_lower{1,k}(:,1)=Pop_Rout_lower(:,k);
end



