tic
clear
clc
%% 创建数据
%各个物品的质量，单位kg
w=[80,82,85,70,72,70,82,75,78,45,49,76,45,35,94,49,76,79,84,74,76,63,...
    35,26,52,12,56,78,16,52, 16,42,18,46,39,80,41,41,16,35,70,72,70,66,50,55,25, 50,55,40];
%各个物品的价值，单位元
p=[200,208,198,192,180,180,168,176,182,168,187,138,184,154,168,175,198,...
    184,158,148,174,135, 126,156,123,145,164,145,134,164,134,174,102,149,134,...
    156,172,164,101,154,192,180,180,165,162,160,158,155, 130,125];    
cap=1000;                                       %每个背包的载重量为1000kg
n=numel(p);                                     %物品个数
%% 参数设置
NIND=500;                                       %种群大小
MAXGEN=500;                                     %迭代次数
Pc=0.9;                                         %交叉概率
Pm=0.08;                                        %变异概率
GGAP=0.9;                                       %代沟
%% 初始化种群
Chrom=InitPop(NIND,n,w,p,cap);
%% 优化
gen=1;
bestIndividual=Chrom(1,:);                      %初始将初始种群中一个个体赋值给全局最优个体
bestObj=Individual_P_W(n,bestIndividual,p,w);   %计算初始bestIndividual的物品总价值
BestObj=zeros(MAXGEN,1);                        %记录每次迭代过程中的最优适应度值
while gen<=MAXGEN
    %% 计算适应度
    Obj=Obj_Fun(Chrom,p,w);                     %计算每个染色体的物品总价值
    FitnV=Obj;                                  %适应度值=目标函数值=物品总价值
    %% 选择
    SelCh=Select(Chrom,FitnV,GGAP);
    %% 交叉操作
    SelCh=Crossover(SelCh,Pc);
    %% 变异
    SelCh=Mutate(SelCh,Pm);
    %% 重插入子代的新种群
    Chrom=Reins(Chrom,SelCh,Obj);
    %% 将种群中不满足载重量约束的个体进行约束处理
    Chrom=adjustChrom(Chrom,w,p,cap);
    %% 记录每次迭代过程中最优目标函数值
    [cur_bestObj,cur_bestIndex]=max(Obj);       %在当前迭代中最优目标函数值以及对应个体的编号
    cur_bestIndividual=Chrom(cur_bestIndex,:);  %当前迭代中最优个体
    %如果当前迭代中最优目标函数值大于等于全局最优目标函数值，则进行更新
    if cur_bestObj>=bestObj
        bestObj=cur_bestObj;
        bestIndividual=cur_bestIndividual;
    end
    BestObj(gen,1)=bestObj;                     %记录每次迭代过程中最优目标函数值
    %% 打印每次迭代过程中的全局最优解
    disp(['第',num2str(gen),'次迭代的全局最优解为：',num2str(bestObj)]);
    %% 更新迭代次数
    gen=gen+1 ;
end
%% 画出迭代过程图
figure;
plot(BestObj,'LineWidth',1);
xlabel('迭代次数');
ylabel('目标函数值（物品总价值）');
%% 最终装进包中的物品序号
pack_item=find(bestIndividual==1);
%% 计算最优装包方案的物品总价值和总重量
[bestP,bestW]=Individual_P_W(n,bestIndividual,p,w);
toc