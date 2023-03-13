function [Pop_Routing Fitness_lower]=Elite_Pop_Initiate_lower(Pop_Routing,Fitness_lower,elite_Pop_Routing,elite_Fitness_lower)
num_elite=size(elite_Pop_Routing{1,1},2);
Popsize=size(Pop_Routing,2);
for pop_dc=1:Popsize
    num_Pop=size(Pop_Routing{1,pop_dc},2);
    randpos=randperm(num_Pop);
    for i=1:Popsize
        pos1=randi(num_elite);
        pos2=randi(num_Pop);
        if Fitness_lower{1,pop_dc}(1,randpos(pos2))<elite_Fitness_lower{1,pop_dc}(1,pos1)
            tempPop_Routing{1,pop_dc}(:,i)=Pop_Routing{1,pop_dc}(:,randpos(pos2));
            tempFitness_lower{1,pop_dc}(1,i)=Fitness_lower{1,pop_dc}(1,randpos(pos2));        
        else
            tempPop_Routing{1,pop_dc}(:,i)=elite_Pop_Routing{1,pop_dc}(:,pos1);
            tempFitness_lower{1,pop_dc}(1,i)=elite_Fitness_lower{1,pop_dc}(1,pos1);                
        end
    end
    tempFitness_lower{1,pop_dc}(2,:)=1:Popsize;
end
Pop_Routing=tempPop_Routing;
Fitness_lower=tempFitness_lower;
