function [path_state]=ADD_state(link_state_1,link_state_2)
%����������·��Ƶ϶ʹ��״̬�߼���

FS_number=length(link_state_1);
for i=1:FS_number
    sum=link_state_1(i)+link_state_2(i);
    if sum>0
        sum=1;%ֻ������״̬����0��ʱ����״̬����0������Ϊ1
    end
    path_state(i)=sum;
end