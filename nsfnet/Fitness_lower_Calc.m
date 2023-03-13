function Fitness_lower=Fitness_lower_Calc(Pop_DCplacement, Pop_Routing,Traffic,topology,K_Path_Traffic,Weight_lower)


for pop_dc=1:size(Pop_DCplacement,2)
     temp_pop_dc=Pop_DCplacement(:,pop_dc);
     pop_routing=Pop_Routing{1,pop_dc};
     for pop_rout=1:size(pop_routing,2)
          temp_pop_rout=pop_routing(:,pop_rout);
          path_traffic=K_Path_Traffic{1,pop_dc};
          temp_fitness_lower=temp_fitness_lower_calc(temp_pop_dc,temp_pop_rout,Traffic,topology,path_traffic,Weight_lower);
          Fitness_lower{1,pop_dc}(1,pop_rout)=temp_fitness_lower;
          Fitness_lower{1,pop_dc}(2,pop_rout)=pop_rout;
     end
end