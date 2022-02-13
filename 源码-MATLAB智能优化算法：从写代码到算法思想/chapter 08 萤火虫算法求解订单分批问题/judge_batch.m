%% 判断一个订单分批是否满足装载量约束，1表示满足，0表示不满足
%输入batch：                       当前订单批次
%输入orders：                      各个订单所包含的物品信息
%输入item_weight：                 每个储位品项的重量
%输入capacity：                    设备最大装载量
%输出flagB：                       标记当前订单批次是否满足装载量约束，1表示满足，0表示不满足
function flagB=judge_batch(batch,orders,item_weight,capacity)
flagB=1;                                                    %初始满足装载量约束
batch_weight=cal_batch_weight(batch,orders,item_weight);    %计算某一批次订单总装载量
%如果不满足装载量，则将flagR设为0
if batch_weight>capacity
    flagB=0;
end
end