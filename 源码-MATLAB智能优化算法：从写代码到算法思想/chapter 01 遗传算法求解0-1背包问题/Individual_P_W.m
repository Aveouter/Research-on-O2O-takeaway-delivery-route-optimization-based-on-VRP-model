%% 计算单个染色体的装包物品总价值和总重量
%输入n：                      物品数目
%输入Individual：             个体
%输入p：                      各个物品价值
%输入w：                      各个物品质量
%输出sumP：                   该个体的装包物品总价值
%输出sumW：                   该个体的装包物品总重量
function [sumP,sumW]=Individual_P_W(n,Individual,p,w)
sumP=0;
sumW=0;
for i=1:n
    %如果为1，则表示物品被装包
    if Individual(i)==1
        sumP=sumP+p(i);
        sumW=sumW+w(i);  
    end
end
end