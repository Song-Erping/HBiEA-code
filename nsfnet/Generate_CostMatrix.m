function [topologyMatrix,costMatrix]=Generate_CostMatrix(Matrix)

%%%%%%%%%%%%%%%%%%%%%%%
%generate the cost martix
%%%%%%%%%%%%%%%%%%%%%%%
[m,n]=size(Matrix);
topologyMatrix=zeros(m,n);
for i=1:m
    for j=1:m
        if Matrix(i,j)==inf
            topologyMatrix(i,j)=0;
        else
            topologyMatrix(i,j)=1;
        end
    end
end
costMatrix=Matrix;
% for i=1:m
%     for j=i:m
%         if topology(i,j)==0
%             costMatrix(i,j)=inf;%if there have not the link between two nodes
%         else
%             costMatrix(i,j)=ceil(rand()*100);%if there have the link between two nodes
%         end
%     end
% end
% costMatrix=costMatrix+costMatrix';%the topology is not director graph