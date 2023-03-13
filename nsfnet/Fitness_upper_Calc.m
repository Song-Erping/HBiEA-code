function Fitness_upper=Fitness_upper_Calc(Pop_DCplacement, Pop_Routing,Traffic,K_Path_Traffic,Total_Vnf,nsfnet_cost,Weight_upper)

for pop_dc=1:size(Pop_DCplacement,2)
     temp_pop_dc=Pop_DCplacement(:,pop_dc);
     pop_routing=Pop_Routing{1,pop_dc};
     for pop_rout=1:size(pop_routing,2)
          temp_pop_rout=pop_routing(:,pop_rout);
          path_traffic=K_Path_Traffic{1,pop_dc};
          temp_fitness_upper=temp_fitness_upper_calc_new1(temp_pop_dc,temp_pop_rout,Traffic,path_traffic,Total_Vnf,nsfnet_cost,Weight_upper);
          Fitness_upper{1,pop_dc}(1,pop_rout)=temp_fitness_upper;
          Fitness_upper{1,pop_dc}(2,pop_rout)=pop_rout;
     end
end