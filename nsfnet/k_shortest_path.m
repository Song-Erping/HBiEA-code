function [k_path,hop,totalCost]=k_shortest_path(k,costMatrix,s,t)
%函数功能是使用k最短路算法计算k条最短路径

%find a shortest path used by dijkstra algorithm
[NodeNum,n]=size(costMatrix);
[path,cost]=dijkstra(NodeNum,costMatrix,s,t);

%%%%%%%%%%%%%%%%%%%%%%%
%define a path data
%route is defined as a shorteset path route
%cost is defined as the path cost
%L is defined as the link to be deleted
%state is defined as the path state,1 means the path has been selected,0 is not
%%%%%%%%%%%%%%%%%%%%%%%
s_path.route=linspace(0,0,NodeNum);
for i=1:length(path)
    s_path.route(i)=path(i);
end
s_path.cost=cost;
s_path.topo=costMatrix;
s_path.state=1;

R=[s_path];
ready=R(1);

y=length(R);
while y<=k
    node=1;
    
    for i=1:length(ready.route)
        if ready.route(node+1)~=0
            i=ready.route(1,node);
            j=ready.route(1,node+1);
            m_costMatrix=ready.topo;
            %modify the cost matrix
            m_costMatrix(i,j)=inf;
            m_costMatrix(j,i)=inf;
            %find a shortest path in modified topology
            [path,cost]=dijkstra(NodeNum,m_costMatrix,s,t);

            %note the shortest path upper
            s_path.route=linspace(0,0,NodeNum);
            for i=1:length(path)
                s_path.route(i)=path(i);
            end
            s_path.cost=cost;
            s_path.topo=m_costMatrix;
            s_path.state=0;

            %if the s_path have not exist in R, add the s_path to R
            marker=1;
            for i=1:length(R)
                if R(i).route==s_path.route
                    marker=0;
                end
            end
            if marker==1
                R=[R,s_path];
            end
            node=node+1;
        end
    end
    
    s_marker=0;
    for i=1:length(R)
        if R(i).state==0
            s_marker=1;
            ready=R(i);
            R(i).state=1;
            break
        end
    end
    if s_marker==0
        break
    end
    y=length(R);
end

y=length(R);
if y<k
    s_path.route=linspace(0,0,NodeNum);
    s_path.cost=inf;
    s_path.topo=zeros(NodeNum,NodeNum);
    s_path.state=0;
    
    for i=1:k-y
        R=[R,s_path];
    end
end

y=length(R);
co=linspace(0,0,y);
for i=1:y
    co(i)=R(i).cost;
end
[so,Ix]=sort(co,2,'ascend');

k_path=zeros(k,NodeNum);
totalCost=linspace(0,0,k);
for i=1:k
    totalCost(i)=R(Ix(i)).cost;
    for j=1:NodeNum
        k_path(i,j)=R(Ix(i)).route(j);
    end
end

hop=linspace(0,0,k);
for i=1:k
    j=1;
   while k_path(i,j)~=0
      hop(i)=hop(i)+1; 
      j=j+1;
   end
   hop(i)=hop(i)-1;
end
