function Pop_Routing=Initiate_Routing(Pop_size,PathNum,Num_Traffic)
for i=1:Pop_size
    for j=1:Pop_size
        for k=1:Num_Traffic
            Pop_Routing{1,i}(k,j)=randi(PathNum);
        end
    end
end