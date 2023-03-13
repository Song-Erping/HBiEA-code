function [bestPop_DC_lower bestPop_Rout_lower]=splitPop(bestPop_DC_Rout,Num_Node)
for pop_dc=1:size(bestPop_DC_Rout,2)
     bestPop_DC_lower(:,pop_dc)=bestPop_DC_Rout(1:Num_Node,pop_dc);
     bestPop_Rout_lower{:,pop_dc}(:,1)=bestPop_DC_Rout(Num_Node+1:end,pop_dc);
end