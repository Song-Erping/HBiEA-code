function Pop_DCplacement=crossover_DCplacement(Pop_DCplacement,NumDC,Pc)

num_Pop=size(Pop_DCplacement,2);
num_Node=size(Pop_DCplacement,1);
for pop_dc=1:num_Pop
    if rand()<Pc
        pos1=randi(num_Pop);
        pos2=randi(num_Pop);
        while pos1==pos2
            pos2=randi(num_Pop);
        end
        father=Pop_DCplacement(:,pop_dc);
        mother1=Pop_DCplacement(:,pos1);
        mother2=Pop_DCplacement(:,pos2);
        tempArray1=father*mother1';
        tempArray2=father*mother2';
        [Row Col]=size(tempArray1);
        col=randi(Col);
        row=randi(Row);
        a=tempArray1(:,col);        
        b=tempArray2(row,:);
        for i=1:num_Node
            if rand()<=0.5
               temp(i)=a(i)&& b(i);
            else
                temp(i)=a(i) || b(i);
            end
        end        
        Pop_DCplacement(:,pop_dc)=temp;
        if sum(Pop_DCplacement(:,pop_dc))~=NumDC
            if sum(Pop_DCplacement(:,pop_dc))<NumDC
                pos_zero=find(temp==0);
                num=NumDC-sum(Pop_DCplacement(:,pop_dc));
                randpos=randperm(size(pos_zero,2));
                Pop_DCplacement(pos_zero(randpos(1:num)),pop_dc)=1;
            else
                pos_zero=find(temp==1);
                num=sum(Pop_DCplacement(:,pop_dc))-NumDC;
                randpos=randperm(size(pos_zero,2));
                Pop_DCplacement(pos_zero(randpos(1:num)),pop_dc)=0;
            end
        end
    end
end