function [elite_Pop_Routing  elite_Fitness_lower]=Sorting_and_Elite_lower(Pop_DCplacement, Pop_Routing,Fitness_lower,Num_Elite)

Pop_size=size(Pop_DCplacement,2);
for pop_dc=1:Pop_size
     num=1;
     A=[Pop_size pop_dc];
     temp_Fitness=Fitness_lower{1,pop_dc};
     temp_Fitness=sortrows(temp_Fitness',1);
     B=size(temp_Fitness);
     C=size(Pop_Routing{1,pop_dc});
     D=temp_Fitness(1:Num_Elite,2);
     E=max(D);
     for i=1:size(temp_Fitness,1)
         if num<=Num_Elite
             if temp_Fitness(i,2)<=C(2)
                 pos(num)=temp_Fitness(i,2);
                 num=num+1;
             end
         else
             break;
         end
     end
     elite_Pop_Routing{1,pop_dc}=Pop_Routing{1,pop_dc}(:,pos);
     temp_Fitness(1:Num_Elite,2)=1:Num_Elite;
     elite_Fitness_lower{1,pop_dc}=temp_Fitness(1:Num_Elite,:)';
end