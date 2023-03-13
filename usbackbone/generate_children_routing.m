function [offspring_father offspring_mother]=generate_children_routing(father,mother)
offspring_father=father;
offspring_mother=mother;
num_traffic=length(father);
pos1=randi(num_traffic);
pos2=mod(pos1+randi(num_traffic)-1,num_traffic);
pos1=max(pos1,pos2);
pos2=min(pos1,pos2);

offspring_father(pos1:pos2)=mother(pos1:pos2);
offspring_mother(pos1:pos2)=father(pos1:pos2);