%% 插入操作
%假设当前解为123456，首先随机选择两个位置，然后将这第一个位置上的元素插入到第二个元素后面。
%比如说，第一个选择5这个位置，第二个选择2这个位置，则插入后的解为125346。
%输入Scurr：       当前解
%输出Snew：        经过插入操作后得到的新解
function Snew=Insertion(Scurr)
n=length(Scurr);
seq=randperm(n);
I=seq(1:2);
i1=I(1);
i2=I(2);
if i1<i2
    Snew=Scurr([1:i1-1 i1+1:i2 i1 i2+1:end]);
else
    Snew=Scurr([1:i2 i1 i2+1:i1-1 i1+1:end]);
end
end