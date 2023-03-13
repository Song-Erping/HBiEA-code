function mutPop_Rout=mutation_Routing(Pop_Routing,elite_Pop_Routing,Num_Traffic,Pm)
num_Pop=size(Pop_Routing{1,1},2);
for pop_dc=1:num_Pop
    num=0;
    for pop_rout=1:num_Pop
        a=randperm(num_Pop,2);
       tempPop_routing=Pop_Routing{1,pop_dc};
    temp_elite_Pop_Routing=elite_Pop_Routing{1,pop_dc};
   mutPop_Rout{1,pop_dc}=round(tempPop_routing+Pm*( temp_elite_Pop_Routing-tempPop_routing)+ Pm*(Pop_Routing{1,a(1,1)}-Pop_Routing{1,a(1,2)}));
  B= 5.*ones(Num_Traffic,num_Pop);
      mutPop_Rout{1,pop_dc}= (mod(mutPop_Rout{1,pop_dc}+B,5));
      
       for i=1:Num_Traffic
          for j=1:num_Pop
              if mutPop_Rout{1,pop_dc}(i,j)==0
                 a=randperm(5,1);  
                  mutPop_Rout{1,pop_dc}(i,j)=a;
              end
          end
       end
      
    end
end


end
