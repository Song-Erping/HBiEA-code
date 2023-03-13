function temp_fitness_upper1=temp_fitness_upper_calc_new1(temp_pop_dc,temp_pop_rout,Traffic,Path_Traffic,Total_Vnf,nsfnet_cost,Weight_upper)
global Num_VNF;
num_DC_VNF=zeros(length(temp_pop_dc),Num_VNF);
numTotal_DC_VNF=zeros(length(temp_pop_dc),1);
stand_DC_VNF=std(numTotal_DC_VNF);
num_traffic=size(Traffic,2);
num_dc=sum(temp_pop_dc);
[index,~]=find(temp_pop_dc);
nsfnet_cost_dc=nsfnet_cost(index,index);
a1=size(nsfnet_cost_dc);
num_node=length(temp_pop_dc);
a2=size(nsfnet_cost);
[i,j,v]=find(nsfnet_cost);
b2=sparse(i,j,v,a2(1,1),a2(1,1));
[dist_node, path_node, pred_node] = graphshortestpath(b2,1,a2(1,1));
[dist_dc, path_dc, pred_dc] = graphshortestpath(b2,index(1,1),a1(1,1));
temp_dc_loc=zeros(length(temp_pop_dc),1);
temp_dc_loc(length(temp_pop_dc),1)=Total_Vnf;
max_stand_DC_VNF=std(temp_dc_loc);
for i=1:num_traffic
     current_trafffic=Traffic(1,i);
     vnf_current_trafffic=current_trafffic.vnf;
     dc_node=find(temp_pop_dc==1);
     path_node=Path_Traffic(temp_pop_rout(i),:,i);
    
     potential_node=intersect(dc_node,path_node);
     temp_numTotal_DC_VNF=numTotal_DC_VNF;
     Std_DC_VNF=ones(length(temp_pop_dc),1)*inf;
     for j=1:length(vnf_current_trafffic)
         for k=1:length(potential_node)
              temp_numTotal_DC_VNF(potential_node(k))=temp_numTotal_DC_VNF(potential_node(k))+1;
              Std_DC_VNF(potential_node(k))=std(temp_numTotal_DC_VNF);
         end
         pos=find(Std_DC_VNF==min(Std_DC_VNF));
         num_DC_VNF(pos(1),vnf_current_trafffic(j))=num_DC_VNF(pos(1),vnf_current_trafffic(j))+1;
         numTotal_DC_VNF(pos(1))=numTotal_DC_VNF(pos(1))+1;
     end
     
end
for i=1:num_traffic
     current_trafffic=Traffic(1,i);
     vnf_current_trafffic=current_trafffic.vnf;
     dc_node=find(temp_pop_dc==1);
     path_node=Path_Traffic(temp_pop_rout(i),:,i);
     potential_node=intersect(dc_node,path_node);
     temp_numTotal_DC_VNF=numTotal_DC_VNF;
     Std_DC_VNF=ones(length(temp_pop_dc),1)*inf;
     for j=1:length(vnf_current_trafffic)
         for k=1:length(potential_node)
              temp_numTotal_DC_VNF(potential_node(k))=temp_numTotal_DC_VNF(potential_node(k))+1;
              Std_DC_VNF(potential_node(k))=std(temp_numTotal_DC_VNF);
         end
        [a,~]= size(Std_DC_VNF);
        index=randperm(a);
     R_Std_DC_VNF=Std_DC_VNF(index(1,1),:);
         pos=find(Std_DC_VNF==min(Std_DC_VNF));
         num_DC_VNF(pos(1),vnf_current_trafffic(j))=num_DC_VNF(pos(1),vnf_current_trafffic(j))+1;
         numTotal_DC_VNF(pos(1))=numTotal_DC_VNF(pos(1))+1;
         for s=1:5
             a= num_DC_VNF(s,:);
             [m,n]=hist(a,unique(a));
             [b,c]=size(n);
            Total_DC_VNF(pos(1),s) =b/5;
         end
       numTotal_S_VNF = min( Total_DC_VNF);
     end        
end
 std_DC_VNF=Std_DC_VNF(find(Std_DC_VNF~=inf));
temp_fitness_upper1=Weight_upper*[num_dc/num_node; 1-(dist_dc/dist_node);numTotal_S_VNF(1,1); min(std_DC_VNF)/max( std_DC_VNF)];

     
