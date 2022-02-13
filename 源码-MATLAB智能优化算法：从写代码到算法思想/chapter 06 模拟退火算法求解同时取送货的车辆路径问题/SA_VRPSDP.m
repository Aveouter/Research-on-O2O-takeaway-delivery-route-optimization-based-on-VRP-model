tic
clear
clc
%% 用importdata这个函数来读取文件 
data=importdata('input.txt');
cap=200;
%% 提取数据信息
vertexs=data(:,2:3);                %所有点的坐标x和y
customer=vertexs(2:end,:);          %顾客坐标
cusnum=size(customer,1);            %顾客数
v_num=10;                           %车辆最大允许使用数目
demands=data(2:end,4);              %需求量
pdemands=data(2:end,5);             %回收量
h=pdist(vertexs);
dist=squareform(h);                 %距离矩阵
%% 模拟退火参数
belta=100;                          %违反的装载量约束的惩罚系数
MaxOutIter=2000;                    %外层循环最大迭代次数
MaxInIter=300;                      %里层循环最大迭代次数
T0=1000;                            %初始温度
alpha=0.99;                         %冷却因子
pSwap=0.2;                          %选择交换结构的概率
pReversion=0.5;                     %选择逆转结构的概率
pInsertion=1-pSwap-pReversion;      %选择插入结构的概率
N=cusnum+v_num-1;                   %解长度=顾客数目+车辆最多使用数目-1
%% 随机构造初始解
Scurr=randperm(N);                  %随机构造初始解
[currVC,NV,TD,violate_num,violate_cus]=decode(Scurr,v_num,cusnum,cap,demands,pdemands,dist);       %将初始解转换为初始配送方案
currCost=costFuction(currVC,dist,demands,pdemands,cap,belta);        %求初始配送方案的成本=车辆行驶总距离+belta*违反的装载量约束之和
Sbest=Scurr;                        %初始将全局最优解赋值为初始解
bestVC=currVC;                      %初始将全局最优配送方案赋值为初始配送方案
bestCost=currCost;                  %初始将全局最优解的总成本赋值为初始解总成本
BestCost=zeros(MaxOutIter,1);       %记录每一代全局最优解的总成本
T=T0;                               %温度初始化
%% 模拟退火
for outIter=1:MaxOutIter
    for inIter=1:MaxInIter
        Snew=Neighbor(Scurr,pSwap,pReversion,pInsertion);           %经过邻域结构后产生的新的解
        newVC=decode(Snew,v_num,cusnum,cap,demands,pdemands,dist);  %将新解转换为配送方案
        newCost=costFuction(newVC,dist,demands,pdemands,cap,belta); %求初始配送方案的成本=车辆行驶总距离+belta*违反的装载量约束之和
        %如果新解比当前解更好，则更新当前解，以及当前解的总成本
        if newCost<=currCost 
            Scurr=Snew; 
            currVC=newVC;
            currCost=newCost;
        else 
            %如果新解不如当前解好，则采用退火准则，以一定概率接受新解
            delta=(newCost-currCost)/currCost;              %计算新解与当前解总成本相差的百分比
            P=exp(-delta/T);                                %计算接受新解的概率
            %如果0~1的随机数小于P，则接受新解，并更新当前解，以及当前解总成本
            if rand<=P
                Scurr=Snew; 
                currVC=newVC;
                currCost=newCost;
            end
        end
        %将当前解与全局最优解进行比较，如果当前解更好，则更新全局最优解，以及全局最优解总成本
        if currCost<=bestCost
            Sbest=Scurr;
            bestVC=currVC;
            bestCost=currCost;
        end
    end
    %记录外层循环每次迭代的全局最优解的总成本
    BestCost(outIter)=bestCost;
    %显示外层循环每次迭代的信全局最优解的总成本
    disp(['第',num2str(outIter),'代全局最优解:'])
    [bestVC,bestNV,bestTD,best_vionum,best_viocus]=decode(Sbest,v_num,cusnum,cap,demands,pdemands,dist);
    disp(['车辆使用数目：',num2str(bestNV),'，车辆行驶总距离：',num2str(bestTD),'，违反约束路径数目：',num2str(best_vionum),'，违反约束顾客数目：',num2str(best_viocus)]);
    fprintf('\n')
    %更新当前温度
    T=alpha*T;
end
%% 打印外层循环每次迭代的全局最优解的总成本变化趋势图
figure;
plot(BestCost,'LineWidth',1);
title('全局最优解的总成本变化趋势图')
xlabel('迭代次数');
ylabel('总成本');
%% 打印全局最优解路线图
draw_Best(bestVC,vertexs);
toc