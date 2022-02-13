%% 初始化种群
%输入NIND：                种群大小
%输入n：                   物品数目
%输入w：                   各个物品的质量
%输入p：                   各个物品的价值
%输入cap：                 背包的载重量
%输出Chrom：               初始种群
function Chrom=InitPop(NIND,N,w,p,cap)
Chrom=zeros(NIND,N);                    %用于存储种群
for i=1:NIND
    Chrom(i,:)=encode(N,w,p,cap);       %编码，生成满足约束的个体
end