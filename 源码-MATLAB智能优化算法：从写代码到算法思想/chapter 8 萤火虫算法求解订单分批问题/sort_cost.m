%% 将当前订单分批方案中的订单按照移除成本从大到小排序
%输入batches：             当前订单分批方案
%输入orders：              每个订单所包含的物品信息
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从运输通道进入拣选通道或从拣选通道进入运输通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出SRC：                 移除成本降序排列结果
%输出Sindex：              SRC所对应的订单编号
function [SRC,Sindex]=sort_cost(batches,orders,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle)
sNum=curr_num(batches);                                   %当前解中顾客的数目
SRC=zeros(sNum,1);                                  %存储移除成本从大到小排序
Sindex=zeros(sNum,1);                               %存储移除成本从大到小排序的序号
NV=size(batches,1);                                      %车辆数目
count=1;
for i=1:NV
    batch=batches{i};
    b_copy=batch;
    lr=numel(b_copy);
    for j=1:lr
        r_cost=remove_cost(b_copy(j),batches,orders,side_num,depot_leftAisle,...
            enter_leave_aisle,adjacent_location,adjacent_aisle);   %存储移除的成本
        SRC(count,1)=r_cost;
        Sindex(count)=b_copy(j);                    %存储移除的顾客序号
        count=count+1;                              %计数器加1
    end
end
[SRC,id]=sort(SRC,'descend');                       %将移除成本数组降序排列
Sindex=Sindex(id);                                  %将降序排列数组对应顾客序号
end