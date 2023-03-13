function Fitness_lower=Fitness_Merge(Fitness_lower,offspringFitness_lower)
Popsize1=size(Fitness_lower,2);
for pop_dc=1:Popsize1
    Popsize2=size(Fitness_lower{1,pop_dc},2);
    offspringFitness_lower{1,pop_dc}(2,:)= offspringFitness_lower{1,pop_dc}(2,:)+Popsize2;
    Fitness_lower{1,pop_dc}=[Fitness_lower{1,pop_dc} offspringFitness_lower{1,pop_dc}];
end

