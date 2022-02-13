%% 交换操作
%比如说有6个元素，当前解为123456，我们随机选择两个位置，然后将这两个位置上的元素进行交换。
%比如说，交换2和5两个位置上的元素，则交换后的解为153426。
%输入Individual1：    个体1
%输出Individual2：    经过交换操作后的个体2
function Individual2=Swap(Individual1)
n=length(Individual1);          %个体长度
seq=randperm(n);
I=seq(1:2);
i1=I(1);
i2=I(2);
Individual2=Individual1;
Individual2([i1 i2])=Individual1([i2 i1]);
end