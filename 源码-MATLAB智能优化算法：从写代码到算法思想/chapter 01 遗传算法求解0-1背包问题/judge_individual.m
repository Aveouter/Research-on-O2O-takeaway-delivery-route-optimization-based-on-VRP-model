%% 判断一个个体是否满足背包的载重量约束，1表示满足，0表示不满足
%输入Individual：          个体
%输入w：                   各个物品的质量
%输入cap：                 背包的载重量
%输出flag：                表示一个个体是否满足背包的载重量约束，1表示满足，0表示不满足
function flag=judge_individual(Individual,w,cap)
pack_item= Individual==1;                   %判断第i个位置上的物品是否装包，1表示装包，0表示未装包
w_pack=w(pack_item);                        %找出装进背包中物品的质量
total_w=sum(w_pack);                        %计算装包物品的总质量
flag= total_w<=cap;                         %如果装包物品的总质量小于等于背包的载重量约束，则为1，否则为0
end