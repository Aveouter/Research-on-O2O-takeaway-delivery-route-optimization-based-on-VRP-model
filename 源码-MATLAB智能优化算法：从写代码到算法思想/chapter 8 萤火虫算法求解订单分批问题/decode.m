%% 将当前萤火虫个体解码为订单分批方案
%输入firefly：             当前萤火虫个体
%输入orders：              每个订单所包含的物品信息
%输入batches_maxnum：      允许分批的最大数目
%输入orders_num：          订单数目
%输入capacity：            设备最大装载量
%输入item_weight：         每个储位物品的重量
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出batches：             订单分批方案
%输出batches_num：         订单分批数目
%输出TD：                  总行走距离
%输出violate_batch：       违反约束订单分批数目
%输出violate_order：       违反约束订单数目
function [batches,batches_num,TD,violate_batch,violate_order]=decode(firefly,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
violate_batch=0;                                %违反约束订单批次数目
violate_order=0;                                %违反约束订单数目
batches=cell(batches_maxnum,1);                 %初始化订单分批方案
count=1;                                        %订单批次计数器
split=find(firefly>orders_num);                 %找出萤火虫个体中订单批次分隔数字的位置
n=numel(split);                                 %订单批次分隔数字的数目
for i=1:n
    if i==1                                     %第1个订单批次分隔数字的位置
        batch=firefly(1:split(i));              %提取两个订单批次分隔数字之间的订单
        batch(batch==firefly(split(i)))=[];     %删除订单批次中订单批次分隔数字
    else
        batch=firefly(split(i-1):split(i));     %提取两个订单批次分隔数字之间的订单
        batch(batch==firefly(split(i-1)))=[];   %删除订单批次中订单批次分隔数字
        batch(batch==firefly(split(i)))=[];     %删除订单批次中订单批次分隔数字
    end
    batches{count}=batch;                       %更新订单分批方案
    count=count+1;                              %更新订单批次数目
end
batch=firefly(split(end):end);                  %最后一批订单      
batch(batch==firefly(split(end)))=[];           %删除订单批次中订单批次分隔数字
batches{count}=batch;                           %更新订单分批方案
[batches,batches_num]=deal_batches(batches);    %将batches中空的数组移除
for j=1:batches_num
    batch=batches{j};
    %判第j批订单中是否都满足装载量约束，1表示满足，0表示不满足
    flagR=judge_batch(batch,orders,item_weight,capacity);
    if flagR==0
        violate_order=violate_order+length(batch); %如果第j批订单不满足约束，则违反约束订单数目加第j批订单所包含的订单数目
        violate_batch=violate_batch+1;             %如果第j批订单不满足约束，则违反约束的订单批次数目加1
    end
end
TD=travel_distance(batches,orders,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle);     %该方案总行走距离
end