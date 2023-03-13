function possiablePaths = findPath(Graph, OriginalNode, destination, Weight) %�����������
pathLength = length(OriginalNode);  %length �к����нϴ��
lastNode = OriginalNode(pathLength); 
nextNodes = find(0<Graph(lastNode,:) & Graph(lastNode,:)<inf); %inf�����
GLength = length(Graph);
possiablePaths = []; 
if lastNode == destination  %���һ��·�����һ���ڵ����Ŀ��ڵ㣬˵����·��������·���е�һ��������ֱ��return
    possiablePaths = OriginalNode; 
    possiablePaths(GLength + 1) = Weight;  
    return; 
elseif length( find( OriginalNode == destination ) ) ~= 0  
    return;
end 
for i=1:length(nextNodes)
    if destination == nextNodes(i)   
        tmpPath = cat(2, OriginalNode, destination);   %�������飬cat2 �������� ���ں���
        tmpPath(GLength + 1) = Weight + Graph(lastNode, destination); %�ӳ����鳤�ȣ���һ���ڵ��һ
        possiablePaths( length(possiablePaths) + 1 , : ) = tmpPath;  %tmpPathΪ·����·��
        nextNodes(i) = 0; 
    elseif length( find( OriginalNode == nextNodes(i) ) ) ~= 0   
        nextNodes(i) = 0;  
    end
end
nextNodes = nextNodes(nextNodes ~= 0); 
for i=1:length(nextNodes) 
    tmpPath = cat(2, OriginalNode, nextNodes(i)); 
    tmpPsbPaths = findPath(Graph, tmpPath, destination, Weight + Graph(lastNode, nextNodes(i))); %����������������·������
    possiablePaths = cat(1, possiablePaths, tmpPsbPaths); %cat1 ��������
end

