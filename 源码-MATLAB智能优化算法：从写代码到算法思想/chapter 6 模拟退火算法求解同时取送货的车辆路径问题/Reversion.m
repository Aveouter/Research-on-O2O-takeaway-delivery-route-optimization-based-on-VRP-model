%% 逆转操作
%假设当前解为123456，首先随机选择两个位置，然后将这两个位置之间的元素进行逆序排列。
%比如说，逆转2和5之间的所有元素，则逆转后的解为154326。
%输入Scurr：       当前解
%输出Snew：        经过逆转操作后得到的新解
function Snew=Reversion(Scurr)
n=length(Scurr);
seq=randperm(n);
I=seq(1:2);
i1=min(I);
i2=max(I);
Snew=Scurr;
Snew(i1:i2)=Scurr(i2:-1:i1);
end