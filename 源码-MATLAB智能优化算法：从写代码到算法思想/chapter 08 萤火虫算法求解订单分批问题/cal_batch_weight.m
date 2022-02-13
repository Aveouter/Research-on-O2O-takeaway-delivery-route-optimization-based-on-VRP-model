%% 计算某一批次订单的总装载量
%输入batch：            当前订单批次
%输入orders：           每个订单所包含的物品信息
%输入item_weight：      每个储位中物品的重量
%输出batch_weight：     该批次总装载量
function batch_weight=cal_batch_weight(batch,orders,item_weight)
order_num=numel(batch);                     %该批次订单所包含的订单数目
batch_weight=0;                             %初始该批次订单所包含物品装载量为0
for i=1:order_num
    order_no=batch(i);                      %该批次中订单的编号
    item_set=orders{order_no};              %该订单所包含的物品编号
    item_num=numel(item_set);               %该订单所包含的物品数目
    for j=1:item_num
        batch_weight=batch_weight+item_weight(item_set(j)); %将当前物品重量加到总装载量中
    end
end
end