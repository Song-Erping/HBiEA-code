function [Traffic Total_Vnf]=Generate_Traffic(Num_Node,Num_Traffic)
max_bandwidth=10;
Total_Vnf=0;
global Num_VNF;
for i=1:Num_Traffic
     temp=randperm(Num_Node);
     source=temp(1);
     dest=temp(2);
     num_vnf=randi(ceil(Num_VNF/2));
     Total_Vnf=Total_Vnf+num_vnf;
     temp_vnf=randperm(Num_VNF);
     VNF=sort(temp_vnf(1:num_vnf));
     bandwidth=randi(max_bandwidth,1,1);
     Traffic(1,i).source=source;
     Traffic(1,i).dest=dest;
     Traffic(1,i).vnf=VNF;
     Traffic(1,i).bandwidth=bandwidth;     
end