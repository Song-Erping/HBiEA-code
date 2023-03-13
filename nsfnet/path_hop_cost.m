function [tK_path,tHop,tTotalCost]=path_hop_cost(tK_path)
[Row, Col]=size(tK_path);
tK_path=sortrows(tK_path,Col);
tTotalCost=tK_path(:,Col)';
tK_path=tK_path(:,1:Col-1);
for i=1:Row
    tHop(1,i)=length(find(tK_path(i,:)~=0))-1;
end
