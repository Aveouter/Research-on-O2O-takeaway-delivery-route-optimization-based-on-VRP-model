%% 计算从当前订单分批方案中移除一个订单的成本
%输入order：               被移除的订单
%输入batches：             当前订单分批方案
%输入orders：              每个订单所包含的物品信息
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出r_cost：              该订单的移除成本
function r_cost=remove_cost(order,batches,orders,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle)
H=size(batches,1);                                              %订单批次数目
%% 先找到order属于哪一批次订单
for i=1:H
    batch=batches{i};                                           %第i批次订单
    findi=find(batch==order,1,'first');                         %判断当前订单批次是否有被移除的订单order
    if ~isempty(findi)
        at=i;                                                   %订单order所属的订单批次编号
        break;
    end
end
%% 再计算订单order的移除成本
batch=batches{at,1};                                           %第at批次订单
s_len1=shpath(batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
b_copy=batch;                                                  %复制batch
b_copy(b_copy==order)=[];                                      %如果订单order恰好在当前订单批次中，则将其移除
if ~isempty(b_copy)
    s_len2=shpath(b_copy,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
else
    s_len2=0;
end
r_cost=s_len1-s_len2;                                      %计算移除订单前和移除订单后的行走距离差值
end