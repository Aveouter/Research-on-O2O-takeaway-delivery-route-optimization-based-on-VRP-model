%% 种群初始化
%输入NIND：        种群大小
%输入N：           个体长度
%输出Population：  随机生成的初始种群
function Population=InitPop(NIND,N)
Population=zeros(NIND,N);                %种群初始化为NIND行N列的零矩阵
for i=1:NIND
    Population(i,:)=randperm(N);         %每个个体为1~N的随机排列
end
end