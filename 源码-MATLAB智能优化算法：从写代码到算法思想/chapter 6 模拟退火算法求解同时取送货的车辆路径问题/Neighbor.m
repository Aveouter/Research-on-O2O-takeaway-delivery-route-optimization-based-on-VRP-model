%% 当前解经过邻域操作后得到的新解
%输入Scurr：       当前解
%输入pSwap：       选择交换结构的概率
%输入pReversion：  选择逆转结构的概率
%输入pInsertion：  选择插入结构的概率
%输出Snew：        经过邻域操作后得到的的新解
function Snew=Neighbor(Scurr,pSwap,pReversion,pInsertion)
index=Roulette(pSwap,pReversion,pInsertion);
if index==1
    %交换结构
    Snew=Swap(Scurr);
elseif index==2
    %逆转结构
    Snew=Reversion(Scurr);
else
    %插入结构
    Snew=Insertion(Scurr);
end
end