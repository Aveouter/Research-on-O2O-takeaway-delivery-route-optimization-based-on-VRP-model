%% 计算当前订单分批方案中订单的数目
%输入batches：         订单分批方案
%输出order_num：       当前订单分批方案中订单数目
function order_num=curr_num(batches)
H=size(batches,1);          %订单分批方案中订单批次数目
order_num=0;                %初始订单数目为0
for i=1:H
    batch=batches{i};       %第i批次订单
    n=numel(batch);         %第i批次订单所包含的订单数目
    order_num=order_num+n;  %累加
end
end