function Pop_DCplacement=mutation_DCplacement(Pop_DCplacement,NumDC,Pm)

num_Pop=size(Pop_DCplacement,2);
num_Node=size(Pop_DCplacement,1);
for pop_dc=1:num_Pop
    if rand()<Pm
        num=randi(num_Node);
        temp_pos=randperm(num_Node);
        Pop_DCplacement(temp_pos(1:num),pop_dc)=1-Pop_DCplacement(temp_pos(1:num),pop_dc);
        if sum(Pop_DCplacement(:,pop_dc))~=NumDC
            if sum(Pop_DCplacement(:,pop_dc))<NumDC
                pos_zero=find(Pop_DCplacement(:,pop_dc)==0);
                num=NumDC-sum(Pop_DCplacement(:,pop_dc));
                randpos=randperm(max(size(pos_zero,2),size(pos_zero,1)));
                Pop_DCplacement(pos_zero(randpos(1:num)),pop_dc)=1;
            else
                pos_one=find(Pop_DCplacement(:,pop_dc)==1);
                num=sum(Pop_DCplacement(:,pop_dc))-NumDC;
                randpos=randperm(max(size(pos_one,2),size(pos_one,1)));
                Pop_DCplacement(pos_one(randpos(1:num)),pop_dc)=0;
            end
        end
    end
end