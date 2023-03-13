function offspringPop_Rout=Offspring_Merge(croPop_Rout,mutPop_Rout)
num_Pop1=size(croPop_Rout,2);
num_Pop2=size(mutPop_Rout,2);
for pop_dc=1:num_Pop2
     offspringPop_Rout{1,pop_dc}=[croPop_Rout{1,pop_dc} mutPop_Rout{1,pop_dc}];
end
for pop_dc=num_Pop2+1:num_Pop1
     offspringPop_Rout{1,pop_dc}=croPop_Rout{1,pop_dc};
end
