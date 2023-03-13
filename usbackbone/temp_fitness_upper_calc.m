function temp_fitness_upper=temp_fitness_upper_calc(temp_pop_dc,temp_pop_rout,Traffic,Path_Traffic,Total_Vnf,Weight_upper)
global Num_VNF;
num_DC_VNF=zeros(length(temp_pop_dc),Num_VNF);
numTotal_DC_VNF=zeros(length(temp_pop_dc),1);
stand_DC_VNF=std(numTotal_DC_VNF);
num_traffic=size(Traffic,2);
num_dc=sum(temp_pop_dc);
num_node=length(temp_pop_dc);
temp_dc_loc=zeros(length(temp_pop_dc),1);
temp_dc_loc(length(temp_pop_dc),1)=Total_Vnf;
max_stand_DC_VNF=std(temp_dc_loc);
for i=1:num_traffic
     current_trafffic=Traffic(1,i);
     vnf_current_trafffic=current_trafffic.vnf;
     dc_node=find(temp_pop_dc==1);
     path_node=Path_Traffic(temp_pop_rout(i),:,i);
     potential_node=intersect(dc_node,path_node);
     for j=length(vnf_current_trafffic):-1:1
         stand_DC_VNF=std(numTotal_DC_VNF);
         if stand_DC_VNF==0
             dc_pos=find(num_DC_VNF(potential_node,vnf_current_trafffic(j))~=0);
             if length(dc_pos)==0
                 num_DC_VNF(potential_node(end),vnf_current_trafffic(j))=num_DC_VNF(potential_node(end),vnf_current_trafffic(j))+1;
                 numTotal_DC_VNF(potential_node(end),1)=numTotal_DC_VNF(potential_node(end),1)+1;
             else
                 temp_dc_pos=find(min(num_DC_VNF(dc_pos,vnf_current_trafffic(j)))==num_DC_VNF(dc_pos,vnf_current_trafffic(j)));
                 num_DC_VNF(dc_pos(temp_dc_pos),vnf_current_trafffic(j))=num_DC_VNF(dc_pos(temp_dc_pos),vnf_current_trafffic(j))+1;
                 numTotal_DC_VNF(dc_pos(temp_dc_pos),1)=numTotal_DC_VNF(dc_pos(temp_dc_pos),1)+1;
             end
         else
             dc_pos=find(num_DC_VNF(potential_node,vnf_current_trafffic(j))~=0);
             if length(dc_pos)==0
                 num_DC_VNF(potential_node(end),vnf_current_trafffic(j))=num_DC_VNF(potential_node(end),vnf_current_trafffic(j))+1;
                 numTotal_DC_VNF(potential_node(end),1)=numTotal_DC_VNF(potential_node(end),1)+1;
             else
                 temp_dc_pos=find(min(num_DC_VNF(dc_pos,vnf_current_trafffic(j)))==num_DC_VNF(dc_pos,vnf_current_trafffic(j)));
                 num_DC_VNF(dc_pos(temp_dc_pos),vnf_current_trafffic(j))=num_DC_VNF(dc_pos(temp_dc_pos),vnf_current_trafffic(j))+1;
                 numTotal_DC_VNF(dc_pos(temp_dc_pos),1)=numTotal_DC_VNF(dc_pos(temp_dc_pos),1)+1;
             end
         end
     end
end
temp_fitness_upper=Weight_upper*[num_dc/num_node; stand_DC_VNF/max_stand_DC_VNF];
     
