function Pop_DCplacement=generate_DCplacement(elite_Pop_DCplacement,Num_elite_upper,numDC,alpha)
B=sum(elite_Pop_DCplacement,2)/Num_elite_upper;
num_Pop=size(elite_Pop_DCplacement,1);
P=(1-alpha).*B+rand*alpha*ones(num_Pop,1);

for pop_dc=1:num_Pop
        for i=1:2*Num_elite_upper
            if rand<P(pop_dc,:)
           Pop_DCplacement(pop_dc,i)=1; 
            else
             Pop_DCplacement(pop_dc,i)=0;    
            end 
        end
       
end
end