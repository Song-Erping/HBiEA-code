function [K_Path_Traffic Hop_Traffic totalCost_Traffic]=Path_Calc(Traffic,costMatrix)

for i=1:size(Traffic,2)
    source=Traffic(1,i).source;
    dest=Traffic(1,i).dest;
    tK_path=findPath(costMatrix,source,dest,0);
    [tK_path,tHop,tTotalCost]=path_hop_cost(tK_path);
    K_Path_Traffic{1,i}=tK_path;
    Hop_Traffic{1,i}=tHop;
    totalCost_Traffic{1,i}=tTotalCost;    
end