%% 逆转操作
%有6个顾客，当前鲸鱼个体为123456，我们随机选择两个位置，然后将这两个位置之间的元素进行逆序排列。
%比如说，逆转2和5之间的所有元素，则逆转后的鲸鱼个体为154326。
%输入individual：            当前鲸鱼个体
%输出new_individual：        经过逆转操作后得到的新的鲸鱼个体
function new_individual=reversion(individual)
n=length(individual);
seq=randperm(n);
I=seq(1:2);
i1=min(I);
i2=max(I);
new_individual=individual;
new_individual(i1:i2)=individual(i2:-1:i1);
end