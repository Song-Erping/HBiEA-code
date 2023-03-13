function [path_state]=ADD_state(link_state_1,link_state_2)
%计算两条链路的频隙使用状态逻辑和

FS_number=length(link_state_1);
for i=1:FS_number
    sum=link_state_1(i)+link_state_2(i);
    if sum>0
        sum=1;%只有两个状态都是0的时候，总状态才是0，否则为1
    end
    path_state(i)=sum;
end