%% 轮盘赌选择，输出选择邻域结构的序号
%输入pSwap：       选择交换结构的概率
%输入pReversion：  选择逆转结构的概率
%输入pInsertion：  选择插入结构的概率
%输出index：       选择所使用的邻域结构的序号，即序号：1 2 3
function index=Roulette(pSwap,pReversion,pInsertion)
p=[pSwap pReversion pInsertion];
r=rand;
c=cumsum(p);
index=find(r<=c,1,'first');
end