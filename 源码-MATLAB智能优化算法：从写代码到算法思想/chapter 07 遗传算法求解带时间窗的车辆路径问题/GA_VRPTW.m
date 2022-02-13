tic
clear
clc
%% 用xlsread函数来读取xlsx文件
dataset=xlsread('实例验证数据.xlsx','转换后数据','A2:G17');
cap=150;                                                                %车辆最大装载量
v=30/60;                                                                %车辆行驶速度=30km/h=30/60km/min
%% 提取数据信息
E=dataset(1,5);                                                         %配送中心时间窗开始时间
L=dataset(1,6);                                                         %配送中心时间窗结束时间
vertexs=dataset(:,2:3);                                                 %所有点的坐标x和y
customer=vertexs(2:end,:);                                              %顾客坐标
cusnum=size(customer,1);                                                %顾客数
v_num=min(25,cusnum);                                                   %车辆最多使用数目
demands=dataset(2:end,4);                                               %需求量
a=dataset(2:end,5);                                                     %顾客时间窗开始时间[a[i],b[i]]
b=dataset(2:end,6);                                                     %顾客时间窗结束时间[a[i],b[i]]
s=dataset(2:end,7);                                                     %客户点的服务时间
h=pdist(vertexs);                                                       %计算各个节点之间的距离
dist=squareform(h);                                                     %距离矩阵
%% 遗传算法参数设置
alpha=10;                                                               %违反的容量约束的惩罚函数系数
belta=100;                                                              %违反时间窗约束的惩罚函数系数
NIND=50;                                                                %种群大小
MAXGEN=250;                                                             %迭代次数
Pc=0.9;                                                                 %交叉概率
Pm=0.05;                                                                %变异概率
N=cusnum+v_num-1;                                                       %染色体长度=顾客数目+车辆最多使用数目-1
%% 初始化种群
init_vc=init(cusnum,a,demands,cap);                                     %构造初始解
Chrom=init_pop(NIND,N,cusnum,init_vc);
%% 输出随机解的路线和总距离
disp('初始种群中的一个随机值:')
[VC,NV,TD,violate_num,violate_cus]=decode(Chrom(1,:),cusnum,cap,demands,a,b,L,s,dist,v);
disp(['车辆使用数目：',num2str(NV),'，车辆行驶总距离：',num2str(TD),'，违反约束路径数目：',num2str(violate_num),'，违反约束顾客数目：',num2str(violate_cus)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%% 优化
gen=1;
bestChrom=Chrom(1,:);                                                   %初始全局最优个体
bestVC=decode(bestChrom,cusnum,cap,demands,a,b,L,s,dist,v);             %初始全局最优个体所解码的配送方案
bestCost=cost_fuction(bestVC,a,b,s,L,dist,demands,cap,alpha,belta,v);   %初始全局最优个体的总成本       
BestChrom=zeros(MAXGEN,N);                                              %记录每次迭代过程中全局最优个体
BestCost=zeros(MAXGEN,1);                                               %记录每次迭代过程中全局最优个体的总成本
while gen<=MAXGEN
    %% 计算当前代所有个体的目标函数值
    Obj=cal_obj(Chrom,cusnum,cap,demands,a,b,L,s,dist,alpha,belta,v);
    %% 计算种群适应度值
    fit=fitness(Obj);
    %% 选择
    SelCh=binary_tourment_select(Chrom,cusnum,cap,demands,a,b,L,s,dist,alpha,belta,v);
    %% 交叉操作
    SelCh=crossover(SelCh,Pc);
    %% 变异
    SelCh=mutate(SelCh,Pm);
    %% 局部搜索操作
    SelCh=local_search(SelCh,cusnum,cap,demands,a,b,L,s,dist,alpha,belta,v);
    %% 重插入子代的新种群
    Chrom=reins(Chrom,SelCh,Obj);
    %% 计算当前代所有个体总成本
    Obj=cal_obj(Chrom,cusnum,cap,demands,a,b,L,s,dist,alpha,belta,v); 
    %% 找出当前代中最优个体
    [minObj,minIndex]=min(Obj);
    %% 将当前代中最优个体与全局最优个体进行比较，如果当前代最优个体更好，则将全局最优个体进行替换
    if minObj<=bestCost
        bestChrom=Chrom(minIndex(1),:);
        bestCost=minObj;
    end
    %记录每一代全局最优个体，及其总距离
    BestChrom(gen,:)=bestChrom;
    BestCost(gen,:)=bestCost;
    %% 打印当前最优解
    disp(['第',num2str(gen),'代最优解:'])
    [bestVC,bestNV,bestTD,best_vionum,best_viocus]=decode(bestChrom,cusnum,cap,demands,a,b,L,s,dist,v);
    disp(['车辆使用数目：',num2str(bestNV),'，车辆行驶总距离：',num2str(bestTD),'，违反约束路径数目：',num2str(best_vionum),'，违反约束顾客数目：',num2str(best_viocus)]);
    fprintf('\n')
    %% 更新迭代次数
    gen=gen+1 ;
end
%% 打印每次迭代的全局最优个体的总距离变化趋势图
figure;
plot(BestCost,'LineWidth',1);
title('优化过程')
xlabel('迭代次数');
ylabel('总成本');
%% 输出最优解的路线和总距离
disp('最优解:')
[bestVC,bestNV,bestTD,best_vionum,best_viocus]=decode(bestChrom,cusnum,cap,demands,a,b,L,s,dist,v);
disp(['车辆使用数目：',num2str(bestNV),'，车辆行驶总距离：',num2str(bestTD),'，违反约束路径数目：',num2str(best_vionum),'，违反约束顾客数目：',num2str(best_viocus)]);
disp('-------------------------------------------------------------')
%% 画出最终路线图
draw_Best(bestVC,vertexs);
save solution.mat bestVC bestNV bestTD
toc