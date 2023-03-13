function [K_Path_Traffic Hop_Traffic totalCost_Traffic]=path_select(K_Path_Traffic,Hop_Traffic,totalCost_Traffic,Pop_DCplacement,PathNum)

for k=1:size(Pop_DCplacement,2)
    DCplacement=Pop_DCplacement(:,k);
    for j=1:size(K_Path_Traffic,2)
        tK_path=K_Path_Traffic{1,j};
        tHop=Hop_Traffic{1,j};
        tTotalCost=totalCost_Traffic{1,j};
        k_path =[];
        hop =[];
        totalCost=[];
        count=0;
        for i=1:size(tK_path,1)
           DC_local=find(DCplacement~=0);
           nodeset=intersect(DC_local,tK_path(i,:));
           if size(nodeset,1)+ size(nodeset,2)>1
                count=count+1;
                k_path(count,:)=tK_path(i,:);
                hop(1,count)=tHop(1,i);
                totalCost(1,count)=tTotalCost(1,i);            
           end
           if count==PathNum
               break;
           end
        end
        tK_Path_Traffic{1,k}(:,:,j)=k_path;
       
        tHop_Traffic{1,k}(:,j)=hop';
        ttotalCost_Traffic{1,k}(:,j)=totalCost';
    end
end
K_Path_Traffic=tK_Path_Traffic;
Hop_Traffic =tHop_Traffic;
totalCost_Traffic=ttotalCost_Traffic;



