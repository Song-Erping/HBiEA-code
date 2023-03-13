clc
clear
tic
%**************读取网络节点间的cost*************************
usbackbone_cost=load('usbackbone_cost.txt');%读取nsfnet的cost值
%arpanet_cost=load('arpanet_cost.txt');%读取nsfnet的cost值
%chnnet_cost=load('chnnet_cost.txt');%读取nsfnet的cost值
%////////////////////////////////////////////////////////////////////////////////////

%path_cost=load('nsfnet_path_cost.txt');
% path=load('nsfnet_path.txt');
% hop=load('nsfnet_hop.txt');
[topology,cost]=Generate_CostMatrix(usbackbone_cost);

global Num_VNF Frequency_slot_number;
Num_VNF=5; 
Frequency_slot_number=300;
Num_Node=size(topology,1);%物理节点的个数;
   param.Obj = 2;
Num_Traffic=50;
[Traffic Total_Vnf]=Generate_Traffic(Num_Node,Num_Traffic); 

Gen_max=2;
alpha=0.1;
Pm=0.5;
Pop_size=10;
Num_elite_upper=Pop_size/2;
Num_Elite=1;

bestGlobal=[inf inf];
Weight_lower=[0.5 0.5];
Weight_upper=[0.25 0.25 0.25 0.25];
PathNum=5; %KSP中选择的路径条数；
[gloalK_Path_Traffic gloalHop_Traffic gloaltotalCost_Traffic]=Path_Calc(Traffic,cost);

numDC=ceil(0.25*Num_Node);

for tongji=1:1
Pop_DCplacement=Initiate_DCplacement(Pop_size,Num_Node,numDC);
[K_Path_Traffic Hop_Traffic totalCost_Traffic]=path_select(gloalK_Path_Traffic,gloalHop_Traffic,gloaltotalCost_Traffic,Pop_DCplacement, PathNum);
Pop_Routing=Initiate_Routing(Pop_size,PathNum,Num_Traffic); %初始化选路种群
Fitness_upper=Fitness_upper_Calc(Pop_DCplacement,Pop_Routing,Traffic,K_Path_Traffic,Total_Vnf,usbackbone_cost,Weight_upper);

[bestValue_upper bestPop_upper bestPop_DC_upper bestPop_Rout_upper]=min_value(Fitness_upper,Pop_DCplacement,Pop_Routing);
bestValue_upper
Fitness_lower=Fitness_lower_Calc(Pop_DCplacement, Pop_Routing,Traffic,topology,K_Path_Traffic,Weight_lower);
[bestValue_lower bestPop_lower bestPop_DC_lower bestPop_Rout_lower]=min_value(Fitness_lower,Pop_DCplacement,Pop_Routing);
bestValue_lower
[elite_Pop_Routing  elite_Fitness_lower]=Sorting_and_Elite_lower(Pop_DCplacement, Pop_Routing,Fitness_lower,Num_Elite);
[Pop_Routing Fitness_lower]=Elite_Pop_Initiate_lower(Pop_Routing,Fitness_lower,elite_Pop_Routing,elite_Fitness_lower);
count=0;flag=0;
while flag==0
    offspringPop_Rout=mutation_Routing(Pop_Routing,elite_Pop_Routing,Num_Traffic,Pm);
   offspringFitness_lower=Fitness_lower_Calc(Pop_DCplacement, offspringPop_Rout,Traffic,topology,K_Path_Traffic,Weight_lower);
   [cur_bestValue_lower cur_bestPop_lower cur_bestPop_DC_lower cur_bestPop_Rout_lower]=min_value(offspringFitness_lower,Pop_DCplacement,offspringPop_Rout);
    if cur_bestValue_lower<=bestValue_lower
        if cur_bestValue_lower<bestValue_lower
            bestValue_lower= cur_bestValue_lower
            bestPop_lower= cur_bestPop_lower;
            bestPop_DC_lower= cur_bestPop_DC_lower;
            bestPop_Rout_lower= cur_bestPop_Rout_lower;
            count=0;       
            Pop_Routing=Offspring_Merge(Pop_Routing,offspringPop_Rout);
            Fitness_lower=Fitness_Merge(Fitness_lower,offspringFitness_lower);
            [elite_Pop_Routing elite_Fitness_lower]=Sorting_and_Elite_lower(Pop_DCplacement, Pop_Routing,Fitness_lower,Num_Elite);
            [Pop_Routing Fitness_lower]=Elite_Pop_Initiate_lower(Pop_Routing,Fitness_lower,elite_Pop_Routing,elite_Fitness_lower);
        else
            bestPop_lower= [bestPop_lower cur_bestPop_lower];
            bestPop_DC_lower= [bestPop_DC_lower cur_bestPop_DC_lower];
            bestPop_Rout_lower= [bestPop_Rout_lower cur_bestPop_Rout_lower];
        end
    else
        count=count+1;
    end
    if count==1
        flag=1;
        count=0;
    end
end

count=0;flag=0;
for upper_gen=1:Gen_max
    for lower_gen=1:Gen_max
         lower_gen 
      Temp_Fitness_upper1=Fitness_upper_Calc(Pop_DCplacement,Pop_Routing,Traffic,K_Path_Traffic,Total_Vnf,usbackbone_cost,Weight_upper);
       for i=1:Pop_size
        Temp_Fitness_upper(1,i)= Temp_Fitness_upper1{1,i}(1,1);
       end
      [~,index]=sort(Temp_Fitness_upper);
elite_Pop_DCplacement=Pop_DCplacement(:,index(1:Num_elite_upper));
         Pop_DCplacement=generate_DCplacement(elite_Pop_DCplacement,Num_elite_upper,numDC,alpha);
      
         Pop_Routing=Initiate_Routing(Pop_size,PathNum,Num_Traffic);
         [K_Path_Traffic Hop_Traffic totalCost_Traffic]=path_select(gloalK_Path_Traffic,gloalHop_Traffic,gloaltotalCost_Traffic,Pop_DCplacement, PathNum);

       Fitness_upper=Fitness_upper_Calc(Pop_DCplacement,Pop_Routing,Traffic,K_Path_Traffic,Total_Vnf,usbackbone_cost,Weight_upper);
[bestValue_upper bestPop_upper bestPop_DC_upper bestPop_Rout_upper]=min_value(Fitness_upper,Pop_DCplacement,Pop_Routing);         
 Fitness_lower=Fitness_lower_Calc(Pop_DCplacement, Pop_Routing,Traffic,topology,K_Path_Traffic,Weight_lower);
          [cur_bestValue_lower cur_bestPop_lower cur_bestPop_DC_lower cur_bestPop_Rout_lower]=min_value(Fitness_lower,Pop_DCplacement,Pop_Routing);
          if cur_bestValue_lower<=bestValue_lower
              if cur_bestValue_lower<bestValue_lower
                  bestValue_lower= cur_bestValue_lower
                  bestPop_lower= cur_bestPop_lower;
                  bestPop_DC_lower= cur_bestPop_DC_lower;
                  bestPop_Rout_lower= cur_bestPop_Rout_lower;
              else
                  bestPop_lower= [bestPop_lower cur_bestPop_lower];
                  bestPop_DC_lower= [bestPop_DC_lower cur_bestPop_DC_lower];
                  bestPop_Rout_lower= [bestPop_Rout_lower cur_bestPop_Rout_lower];
              end
          end
          [elite_Pop_Routing  elite_Fitness_lower]=Sorting_and_Elite_lower(Pop_DCplacement, Pop_Routing,Fitness_lower,Num_Elite);
          [Pop_Routing, Fitness_lower]=Elite_Pop_Initiate_lower(Pop_Routing,Fitness_lower,elite_Pop_Routing,elite_Fitness_lower);
          while flag==0
                offspringPop_Rout=mutation_Routing(Pop_Routing,elite_Pop_Routing,Num_Traffic,Pm);
   offspringFitness_lower=Fitness_lower_Calc(Pop_DCplacement, offspringPop_Rout,Traffic,topology,K_Path_Traffic,Weight_lower);
              [cur_bestValue_lower cur_bestPop_lower cur_bestPop_DC_lower cur_bestPop_Rout_lower]=min_value(offspringFitness_lower,Pop_DCplacement,offspringPop_Rout);
             if cur_bestValue_lower<=bestValue_lower
                if cur_bestValue_lower<bestValue_lower
                    bestValue_lower= cur_bestValue_lower
                    bestPop_lower= cur_bestPop_lower;
                    bestPop_DC_lower= cur_bestPop_DC_lower;
                    bestPop_Rout_lower= cur_bestPop_Rout_lower;
                    count=0;       
                    Pop_Routing=Offspring_Merge(Pop_Routing,offspringPop_Rout);
                    Fitness_lower=Fitness_Merge(Fitness_lower,offspringFitness_lower);
                    [elite_Pop_Routing  elite_Fitness_lower]=Sorting_and_Elite_lower(Pop_DCplacement, Pop_Routing,Fitness_lower,Num_Elite);
                    [Pop_Routing Fitness_lower]=Elite_Pop_Initiate_lower(Pop_Routing,Fitness_lower,elite_Pop_Routing,elite_Fitness_lower);
                else
                    bestPop_lower= [bestPop_lower cur_bestPop_lower];
                    bestPop_DC_lower= [bestPop_DC_lower cur_bestPop_DC_lower];
                    bestPop_Rout_lower= [bestPop_Rout_lower cur_bestPop_Rout_lower];
                end
            else
                count=count+1;
             end
             if count==1
                flag=1;
                count=0;
             end
          end      
    end
 [bestPop_DC_lower bestPop_Rout_lower]=unique_struct(bestPop_DC_lower,bestPop_Rout_lower);
     Fitness_upper=Fitness_upper_Calc(bestPop_DC_lower, bestPop_Rout_lower,Traffic,K_Path_Traffic,Total_Vnf,usbackbone_cost,Weight_upper);
         
     bestPop_Rout_lower=cell2matrix(bestPop_Rout_lower);
     

     bestGlobal=Optimal_update(bestGlobal,bestValue_upper,bestValue_lower);
end
bestGlobal
toc
tongji
BESTGLOBAL(tongji,:)=bestGlobal;
end











