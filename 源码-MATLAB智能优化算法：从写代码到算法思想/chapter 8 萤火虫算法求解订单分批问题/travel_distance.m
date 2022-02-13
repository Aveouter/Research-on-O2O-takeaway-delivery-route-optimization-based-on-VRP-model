%% 计算订单分批方案的拣选总行走距离，以及每批次订单的拣选行走距离
%输入batches：             所有订单的分批结果
%输入orders：              每个订单所包含的物品信息
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出sumTD：               拣选总行走距离
%输出everyTD：             拣选每批次订单所行走的距离
function [sumTD,everyTD]=travel_distance(batches,orders,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle)
H=size(batches,1);                      %订单批次数目
everyTD=zeros(H,1);
for i=1:H
    batch=batches{i,1};                 %第i批次订单
    if ~isempty(batch)
        %每批次订单的拣选行走距离
        everyTD(i)=shpath(batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    end
end
sumTD=sum(everyTD);                     %订单分批方案的拣选总行走距离
end