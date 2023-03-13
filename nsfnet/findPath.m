function possiablePaths = findPath(Graph, OriginalNode, destination, Weight) %深度优先搜索
pathLength = length(OriginalNode);  %length 行和列中较大的
lastNode = OriginalNode(pathLength); 
nextNodes = find(0<Graph(lastNode,:) & Graph(lastNode,:)<inf); %inf无穷大
GLength = length(Graph);
possiablePaths = []; 
if lastNode == destination  %如果一条路的最后一个节点就是目标节点，说明此路径是所有路径中的一条，可以直接return
    possiablePaths = OriginalNode; 
    possiablePaths(GLength + 1) = Weight;  
    return; 
elseif length( find( OriginalNode == destination ) ) ~= 0  
    return;
end 
for i=1:length(nextNodes)
    if destination == nextNodes(i)   
        tmpPath = cat(2, OriginalNode, destination);   %联结数组，cat2 按行联结 加在后面
        tmpPath(GLength + 1) = Weight + Graph(lastNode, destination); %延长数组长度，多一个节点加一
        possiablePaths( length(possiablePaths) + 1 , : ) = tmpPath;  %tmpPath为路径的路阻
        nextNodes(i) = 0; 
    elseif length( find( OriginalNode == nextNodes(i) ) ) ~= 0   
        nextNodes(i) = 0;  
    end
end
nextNodes = nextNodes(nextNodes ~= 0); 
for i=1:length(nextNodes) 
    tmpPath = cat(2, OriginalNode, nextNodes(i)); 
    tmpPsbPaths = findPath(Graph, tmpPath, destination, Weight + Graph(lastNode, nextNodes(i))); %把满足条件的所有路径联结
    possiablePaths = cat(1, possiablePaths, tmpPsbPaths); %cat1 加在下面
end

