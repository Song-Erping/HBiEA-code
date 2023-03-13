function [bestValue bestPop bestPop_DC bestPop_Rout]=min_value(Fitness,Pop_DCplacement,Pop_Routing)

Pop_size1=size(Fitness,2);

bestValue=inf;
num=0;
for i=1:Pop_size1
    Pop_size2=size(Fitness{1,i},2);
    for j=1:Pop_size2
         if Fitness{1,i}(1,j)<=bestValue
             if Fitness{1,i}(1,j)<bestValue
                 bestValue=Fitness{1,i}(1,j);
                 num=1;
                 tempbestPop(1,num)=i;
                 tempbestPop(2,num)=j;
             else
                 bestValue=Fitness{1,i}(1,j);
                 num=num+1;
                 tempbestPop(1,num)=i;
                 tempbestPop(2,num)=j;
             end
         end
    end
end
bestPop_DC=Pop_DCplacement(:,tempbestPop(1,:));
num=size(tempbestPop,2);
for k=1:num
    bestPop_Rout(:,k)=Pop_Routing{1,tempbestPop(1,k)}(:,tempbestPop(2,k));
end

bestPop=[bestPop_DC' bestPop_Rout']';
flag_arr=zeros(1,num);
for j=1:num
    for k=j+1:num
        if flag_arr(j)==0
            flag=(sum(bestPop(:,j)==bestPop(:,k))==size(bestPop,1));
            if flag==1
               flag_arr(k)=1;
            end
        end
    end
end
pos=find(flag_arr==0);
bestPop=bestPop(:,pos);

bestPop_DC=bestPop(1:size(bestPop_DC,1),:);
bestPop_Rout=bestPop(size(bestPop_DC,1)+1:end,:);
bestPop=tempbestPop(:,pos);

