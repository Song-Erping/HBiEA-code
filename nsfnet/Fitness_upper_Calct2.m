function Fitness_upper2=Fitness_upper_Calct2(Pop_DCplacement, Pop_Routing,Traffic,K_Path_Traffic,Total_Vnf,Weight_upper)

for pop_dc=1:size(Pop_DCplacement,2)
     temp_pop_dc=Pop_DCplacement(:,pop_dc);
     pop_routing=Pop_Routing{1,pop_dc};
     for pop_rout=1:size(pop_routing,2)
          temp_pop_rout=pop_routing(:,pop_rout);
          path_traffic=K_Path_Traffic{1,pop_dc};
          temp_fitness_upper2=temp_fitness_upper_calc_new2(temp_pop_dc,temp_pop_rout,Traffic,path_traffic,Total_Vnf,Weight_upper);
          Fitness_upper2{1,pop_dc}(1,pop_rout)=temp_fitness_upper2;
          Fitness_upper2{1,pop_dc}(2,pop_rout)=pop_rout;
     end
end