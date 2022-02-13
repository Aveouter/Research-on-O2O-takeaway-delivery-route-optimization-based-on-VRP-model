%% 局部搜索操作
%输入offspring：           被选择的萤火虫个体          
%输入orders：              每个订单所包含的物品信息
%输入batches_maxnum：      最大允许分批的数目
%输入orders_num：          订单数目
%输入capacity：            设备最大装载量
%输入item_weight：         每个储位品项的重量
%输入alpha：               违反设备装载量约束的惩罚因子
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输入alpha：               违反设备装载量约束的惩罚因子
%输出offspring：           局部搜索后的萤火虫个体
function offspring=local_search(offspring,orders,batches_maxnum,orders_num,capacity,item_weight,alpha,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
D=15;                                                %Remove过程中的随机元素
toRemove=min(ceil(orders_num/2),15);                 %将要移出订单数目
N=size(offspring,2);                                 %萤火虫个体长度
Obj1=obj_function(offspring,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha); %计算局部搜索前offspring的目标函数值Obj1
off_num=size(offspring,1);              %offspring中萤火虫的数目
for i=1:off_num
    %% 解码
    batches=decode(offspring(i,:),orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %% 移除操作
    [removed,r_batches]=worst_remove(toRemove,D,batches,orders,side_num,...
        depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %% 插入操作
    ReBatches=greedy_ins(removed,r_batches,orders,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %% 计算修复后的订单分批方案总成本
    RCF=cost_function(ReBatches,orders,item_weight,capacity,side_num,depot_leftAisle,...
        enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
    %% 只有修复后的订单分批方案更优，才能接受修复后的订单分批方案
    if RCF<Obj1(i,1)
        offspring(i,:)=change(ReBatches,N,orders_num);
    end
end
end