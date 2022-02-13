%% WorstRemove操作，移除高成本的订单
%输入toRemove：            移除订单的数目
%输入D：                   随机元素
%输入batches：             当前订单分批方案
%输入orders：              每个订单所包含的物品信息
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出removed：             移除订单的集合
%输出r_batches：           移除removed中订单后的订单分批方案
function [removed,r_batches]=worst_remove(toRemove,D,batches,orders,side_num,...
        depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
currB=batches;
removed=[];
while toRemove>0          
    [SRC,Sindex]=sort_cost(currB,orders,side_num,depot_leftAisle,...
        enter_leave_aisle,adjacent_location,adjacent_aisle);% 将当前解中的订单按照移除成本从大到小排序
    ls=size(Sindex,1);                                  %当前解中订单数目
    rvc=Sindex(ceil(rand^D*ls));                        %选择被移除的订单
    removed=[removed rvc];                              %将被移除的订单添加到集合中
    currB=dealRemove(rvc,currB);                        %将订单从当前解中移除
    toRemove=toRemove-1;                                %更新被移除订单数目
end
r_batches=currB;
end