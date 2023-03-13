function bestGlobal=Optimal_update(bestGlobal,bestValue_upper,bestValue_lower)
if bestValue_lower<=bestGlobal(2)
    if bestValue_lower<bestGlobal(2)
        bestGlobal=[bestValue_upper bestValue_lower];
    else
        if bestValue_upper<bestGlobal(1)
            bestGlobal=[bestValue_upper bestValue_lower];
        end
    end
end