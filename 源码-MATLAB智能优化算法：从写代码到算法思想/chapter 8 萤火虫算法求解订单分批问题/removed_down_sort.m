%% 将removed中订单按照拣选行走距离由大到小排序
%输入removed：             被移除的订单集合
%输入orders：              每个订单所包含的物品信息
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出sRemoved：            将removed排序后的结果
function sRemoved=removed_down_sort(removed,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
lr=numel(removed);              %被移除订单的数目
len=zeros(lr,1);                %存储removed中各订单的拣选行走距离
for i=1:lr
    order=removed(i);           %第i个被移除的订单
    %记录order的拣选行走距离
    len(i)=shpath(order,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
end
[~,sindex]=sort(len,'descend'); %将len降序排列
sRemoved=removed(sindex);
end