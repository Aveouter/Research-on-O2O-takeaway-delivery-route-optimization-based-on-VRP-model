%% 编码，生成满足约束的个体
%输入n：                   物品数目
%输入w：                   各个物品的质量
%输入p：                   各个物品的价值
%输入cap：                 背包的载重量
%输出Individual：          满足背包载重量约束的个体
function Individual=encode(n,w,p,cap)
Individual=round(rand(1,n));                                %随机生成n个数字（每个数字是0或1）
flag=judge_individual(Individual,w,cap);                    %判断Individual是否满足背包的载重量约束，1表示满足，0表示不满足
%% 如果flag为0，则需要修复个体Individual。否则，不需要修复
if flag==0
    Individual=repair_individual(Individual,w,p,cap);       %修复个体Individual
end
end