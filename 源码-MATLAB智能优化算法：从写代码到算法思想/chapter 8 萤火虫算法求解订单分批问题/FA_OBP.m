tic
clear
clc
%% 导入订单数据和各个储位物品的重量数据
load orders.mat orders
load item_weight.mat item_weight
%% 仓库参数初始化
depot_leftAisle=1.5;        %仓库与第1条拣选通道的距离，1.5LU
enter_leave_aisle=1;        %从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
adjacent_location=1;        %同一条拣选通道的两个相邻储位之间的距离，1LU
adjacent_aisle=5;           %两个相邻拣选通道的距离，5LUs
aisle_num=10;               %拣选通道数目
side_num=15;                %每条拣选通道一侧的储位数目
capacity=100;               %设备最大装载量，单位kg
%% 订单数据数据初始化
orders_num=20;              %订单数目
batches_maxnum=10;          %允许分批的最大数目
%% 萤火虫算法参数初始化
MAXGEN=100;                         %最大迭代次数
NIND=50;                            %萤火虫数目
N=batches_maxnum+orders_num-1;      %编码长度
alpha=2000;                         %违反设备装载量约束的惩罚因子
gama=0.95;                          %光吸收系数
%% 初始化
Population=init_pop(NIND,N);        %随机初始化
best_firefly=Population(1,:);       %初始全局最优
[batches,batches_num,bestTD,violate_batch,violate_order]=decode(best_firefly,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
disp(['初始订单分批数目：',num2str(batches_num),'，总行驶距离：',num2str(bestTD),...
    '，违反约束订单分批数目：',num2str(violate_batch),'，违反约束订单数目：',num2str(violate_order)]);
best_cost=cost_function(batches,orders,item_weight,capacity,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);   %初始全局最优分批方案的总行驶距离
Best_Cost=zeros(MAXGEN,1);          %记录每一次迭代全局最优总距离
Best_TD=zeros(MAXGEN,1);          %记录每一次迭代全局最优总距离
%% 主循环
gen=1;
while gen<=MAXGEN
    %% 计算种群目标函数值
    Obj=obj_function(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
    %% 更新萤火虫位置
    for i=1:NIND
        Individual1=Population(i,:);                    %第i个萤火虫
        for j=1:NIND
            Individual2=Population(j,:);            %第j个萤火虫
            %如果第j个萤火虫发光强度更大，则需要将第i个萤火虫向第j个萤火虫靠近
            if Obj(j,1)<Obj(i,1)
                rij=cal_rij(Individual1,Individual2);   %计算两个萤火虫之间的距离
                cross_len=randi([1,ceil(rij*gama^gen)],1,1);    %计算交叉片段长度
                [Individual1,Individual2]=crossover(Individual1,Individual2,cross_len);     %交叉操作，得到新的第i个萤火虫
                newObj1=obj_function(Individual1,orders,batches_maxnum,orders_num,capacity,item_weight,...
                    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);%交叉后得到的新萤火虫
                if newObj1<Obj(i,1)
                    Population(i,:)=Individual1;                     %更新新种群第i个萤火虫位置
                    Obj(i,1)=newObj1;
                    %更新新种群中第i个萤火虫的目标函数值
                end
            end
        end
    end
    %% 从更新后的Population中选择目标函数值在前10%的个体
   offspring=select(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
    %% 局部搜索
    offspring=local_search(offspring,orders,batches_maxnum,orders_num,capacity,item_weight,alpha,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %% 将局部搜索后的offspring与原来的Population进行合并
    Population=merge(Population,offspring,Obj);
    %% 找到全局最优的萤火虫
    Obj=obj_function(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
    [min_Obj,min_index]=min(Obj);                              %排在第1位的是最小目标函数值
    if min_Obj<best_cost
        best_firefly=Population(min_index,:);                   %更新全局最优萤火虫
        best_cost=min_Obj;
    end
    Best_Cost(gen,1)=best_cost;                   %记录每次迭代全局最优目标函数值
    %% 打印
    [best_batches,batches_num,bestTD,violate_batch,violate_order]=decode(best_firefly,orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    disp(['第',num2str(gen),'代全局最优萤火虫订单分批数目：',num2str(batches_num),'，总行驶距离：',num2str(bestTD),...
        '，违反约束订单分批数目：',num2str(violate_batch),'，违反约束订单数目：',num2str(violate_order)]);
    %% 记录全局最优总行走距离
    Best_TD(gen,1)=bestTD;
    %% 计数器加1
    gen=gen+1;
end
%% 输出优化过程图
figure;
plot(Best_TD,'LineWidth',1);
title('优化过程')
xlabel('迭代次数');
ylabel('拣选总行走距离');
%% 将全局最优萤火虫解码为订单分批方案
[best_batches,best_num,bestTD]=decode(best_firefly,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
toc