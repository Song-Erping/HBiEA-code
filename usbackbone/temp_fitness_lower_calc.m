function temp_fitness_upper=temp_fitness_upper_calc(temp_pop_dc,temp_pop_rout,Traffic,topology,path_traffic,Weight_lower)

Frequency_slot_number=2000;    
protect_slot=2;
lose_num=0;
factor=1000;%ϵ������
num_traffic=size(Traffic,2);
node_num=length(temp_pop_dc);
link_state_matric={};%������·Ƶ϶ʹ��״̬������cell����
link_state=zeros(1,Frequency_slot_number);%��ʼ����·Ƶ϶ʹ��״̬��0��ʾû��ʹ�ã�1��ʾ�Ѿ�ʹ��

for j=1:node_num
    for i=1:node_num
        link_state_matric{i,j}=inf;%cell�������õ�ʱ��һ��Ҫ�û�����{}
        if topology(i,j)==1
            link_state_matric{i,j}=link_state;%�ڴ�����·�ĵط���ʼ����·Ƶ϶ʹ��״̬
        end
    end
end

path=linspace(0,0,node_num);
traffic_translation=Traffic;

for t=1:num_traffic
        source=traffic_translation(1,t).source;
        dest=traffic_translation(1,t).dest;
        bandwidth=max(traffic_translation(1,t).bandwidth);   

        path=path_traffic(temp_pop_rout(t),:,t);
        path_len=length(path);
        path_state=linspace(0,0,Frequency_slot_number);%��ʼ��·��Ƶ϶ʹ��״̬��0��ʾû��ʹ�ã�1��ʾ�Ѿ�ʹ�� 
        
        for i=1:path_len-1
            s=path(i);
            d=path(i+1);
            if d==0
                break;
            end
            path_state=ADD_state(path_state,link_state_matric{s,d});
        end

        success=0;
        for i=1:Frequency_slot_number-bandwidth+1
            mark=0;
            for j=i:i+bandwidth-1
               if path_state(j)==1
                   mark=1;
                   break
               end
            end
            if mark==0
                start_slot=i;
                for j=1:path_len-1
                   s=path(j);
                   d=path(j+1);
                   if d~=0
                       for k=start_slot:start_slot+bandwidth-1
                          link_state_matric{s,d}(k)=1; 
                       end
                   end
                end
                success=1;
                slove(t,1)=source;
                slove(t,2)=dest;
                slove(t,3)=bandwidth;
                slove(t,4)=start_slot;
                break
            end
        end
        if success==0
          lose_num=lose_num+1;  
        end    
    end%for t

    %������μ�ע�͵ĳ�����Ҫ���Ǽ�¼������ʹ�õ����Ƶ϶�ţ������м��п����п���Ƶ϶δʹ��
    FS_matric=zeros(node_num,node_num);
    for j=1:node_num
        for i=1:node_num
            if link_state_matric{i,j}~=inf
                %ͳ��ÿ����·��ʹ�õ����Ƶ϶��
                FS_use=0;
                for f=1:Frequency_slot_number
                    if link_state_matric{i,j}(f)==1
                        FS_use=f;
                    end
                end
                FS_matric(i,j)=FS_use;%������Ƶ϶�ŷ���FS_matric������
            end
        end
    end
    %�ҳ�������������·ʹ��Ƶ϶��
    max_FS=max(max(FS_matric));


    %������γ����Ǽ������������Ƶ϶ʹ�ø���
    network_state=linspace(0,0,Frequency_slot_number);%��ʼ�������Ƶ϶ʹ��״̬
    total_used_slot=0;
    link_num=0;
    for i=1:node_num
        for j=1:node_num
            if link_state_matric{i,j}~=inf
                link_num=link_num+1;%tͳ����·����
                for fs=1:Frequency_slot_number
                   if link_state_matric{i,j}(fs)==1
                       total_used_slot=total_used_slot+1;%��¼����ʹ�õ�Ƶ϶����
                   end
                end
                network_state=ADD_state(network_state,link_state_matric{i,j});%�������������Ƶ϶ʹ��״̬
            end
        end
    end
    total_used_slot=total_used_slot-protect_slot*num_traffic;%���ʹ��Ƶ϶�������ʱ��Ҫȥ������Ƶ϶
    use_FS=0;
    for fs=1:Frequency_slot_number
        if network_state(fs)==1
            use_FS=use_FS+1;
        end
    end
    fs_useage_percent=total_used_slot/(Frequency_slot_number*link_num);
    
%     totalPro_DC_used=0;
%     for dc=1:num_traffic
%         for k=1:length(Pop_VNF_Placement{dc,pop})
%             totalPro_DC_used=totalPro_DC_used+Pro_DC(1,Pop_VNF_Placement{dc,pop}(k)).eta;
%         end
%     end
    
    f1=max_FS/Frequency_slot_number;
    f2=fs_useage_percent;
    
  temp_fitness_upper=Weight_lower*[f1;f2];

    
end
