function [K_Path_Traffic Hop_Traffic totalCost_Traffic]=Path_Calc_new(Traffic,costMatrix,PathNum,Pop_DCplacement)

% for i=1:size(Traffic,2)
%     source=Traffic(1,i).source;
%     dest=Traffic(1,i).dest;
%     vnf=Traffic(1,i).vnf;       
%     [tK_path tHop tTotalCost]=k_shortest_path(PathNum,costMatrix,source,dest);
% 
%     K_Path_Traffic(:,:,i)=tK_path;
%     Hop_Traffic(:,i)=tHop';
%     totalCost_Traffic(:,i)=tTotalCost';
% end
for j=1:size(Pop_DCplacement,2)
    DCplacement=Pop_DCplacement(:,j);
    for i=1:size(Traffic,2)
        source=Traffic(1,i).source;
        dest=Traffic(1,i).dest;
        tK_path=findPath(costMatrix,source,dest,0);
        [tK_path,tHop,tTotalCost]=path_hop_cost(tK_path);
        [k_path hop totalCost]=path_select(tK_path,tHop,tTotalCost,DCplacement);
        k_path=k_path(1:PathNum,:);
        hop=hop(1,1:PathNum);
        totalCost=totalCost(1,1:PathNum);
        K_Path_Traffic{1,j}(:,:,i)=k_path;
        Hop_Traffic{1,j}(:,i)=hop';
        totalCost_Traffic{1,j}(:,i)=totalCost';
    end
end