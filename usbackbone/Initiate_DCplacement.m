function Pop_DCplacement=Initiate_DCplacement(Pop_size,Num_Node,Num_DC)

Pop_DCplacement=zeros(Num_Node,Pop_size);
for i=1:Pop_size
     Seq_Node=randperm(Num_Node);
     DC_Node=Seq_Node(1:Num_DC);
     Pop_DCplacement(DC_Node,i)=1;
end
