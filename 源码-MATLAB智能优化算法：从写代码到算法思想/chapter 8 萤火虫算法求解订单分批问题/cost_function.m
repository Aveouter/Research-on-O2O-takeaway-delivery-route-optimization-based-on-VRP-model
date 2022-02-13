%% 计算一个订单分批方案的总成本，即等于该订单方案的总行走距离+alpha*违反设备装载量约束成本之和
%输入batches：             订单分批方案
%输入orders：              每个订单所包含的物品信息
%输入item_weight：         每个储位品项的重量
%输入capacity：            设备最大装载量
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输入alpha：               违反拣货设备装载量约束的惩罚因子
%输出cost：                订单分批方案的总成本
function cost=cost_function(batches,orders,item_weight,capacity,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle,alpha)
H=size(batches,1);                 %订单分批数目
%% 计算订单分批方案的总行走距离cost1
cost1=travel_distance(batches,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
%% 违反设备装载量约束成本之和cost2
cost2=0;                            %初始违反设备装载量约束之和
for i=1:H
    batch=batches{i,1};             %第i批次订单
    batch_weight=cal_batch_weight(batch,orders,item_weight);    %第i批次订单装载量
    %如果第i批次订单装载量大于设备装载量，则对cost1进行累加
    if batch_weight>capacity
        cost2=cost2+batch_weight-capacity;
    end
end
%% 总成本=cost1+alpha*cost2
cost=cost1+alpha*cost2;
end