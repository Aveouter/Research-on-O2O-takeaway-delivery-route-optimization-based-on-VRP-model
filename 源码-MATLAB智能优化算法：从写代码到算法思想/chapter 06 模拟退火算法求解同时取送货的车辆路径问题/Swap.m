%% 交换操作
%假设当前解为123456，首先随机选择两个位置，然后将这两个位置上的元素进行交换。
%比如说，交换2和5两个位置上的元素，则交换后的解为153426。
%输入Scurr：       当前解
%输出Snew：        经过交换操作后得到的新解
function Snew=Swap(Scurr)
n=length(Scurr);
seq=randperm(n);
I=seq(1:2);
i1=I(1);
i2=I(2);
Snew=Scurr;
Snew([i1 i2])=Scurr([i2 i1]);
end