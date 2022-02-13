%% 计算种群中每个染色体的物品总价值
%输入Chrom：               种群
%输入p：                   各个物品的价值
%输入w：                   各个物品的质量
%输出Obj：                 种群中每个个体的物品总价值
function Obj=Obj_Fun(Chrom,p,w)
NIND=size(Chrom,1);        %种群大小
n=size(Chrom,2);           %物品数目
Obj=zeros(NIND,1);
for i=1:NIND
    Obj(i,1)=Individual_P_W(n,Chrom(i,:),p,w);
end
end