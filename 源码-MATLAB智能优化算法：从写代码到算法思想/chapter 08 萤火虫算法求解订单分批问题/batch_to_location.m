%% 将一批次订单转换为该批次订单所包含的拣选位置集合
%输入batch：               一批次订单
%输入orders：              每个订单所包含的物品信息
%输出pickloc_set：         该批次订单所包含的拣选位置集合
function pickloc_set=batch_to_location(batch,orders)
order_num=numel(batch);                         %该批次订单所包含订单数目
pickloc_set=[];                                 %初始化批次订单所包含的拣选位置集合为空集
for i=1:order_num
    pickloc_set=[pickloc_set,orders{batch(i)},1]; %逐个将每个订单所包含的物品编号添加到pick_set中
end
pickloc_set=unique(pickloc_set);                %删除重复储位
end