%% 调整种群染色体，将不满足载重量约束的染色体进行调整
%输入Chrom：               种群
%输入w：                   各个物品的质量
%输入p：                   各个物品的价值
%输入cap：                 背包载重量
%输出Chrom：               调整后的染色体，全部满足载重量约束
function Chrom=adjustChrom(Chrom,w,p,cap)
NIND=size(Chrom,1);                                             %NIND种群大小
for i=1:NIND
    Individual=Chrom(i,:);                                      %第i个个体
    flag=judge_individual(Individual,w,cap);                    %判断random_Individual是否满足背包的载重量约束，1表示满足，0表示不满足
    %% 如果flag为0，则需要修复个体Individual。否则，不需要修复
    if flag==0
        Individual=repair_individual(Individual,w,p,cap);       %修复个体Individual
        Chrom(i,:)=Individual;                                  %更新第i个个体
    end
end
end