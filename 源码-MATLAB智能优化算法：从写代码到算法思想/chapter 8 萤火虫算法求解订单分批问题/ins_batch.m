%% 判断能否将一个订单插入到一批次订单中，如果能，则将该订单插入到最佳订单批次
%输入order：               待插回的订单
%输入orders：              每个订单所包含的物品信息
%输入batch：               当前批次订单
%输入capacity：            设备最大装载量
%输入item_weight：         每个储位品项的重量
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出new_batch：           如果插入成功，则为新订单分批，如果插入失败，则为原订单分批
%输出flag：                标记是否能顺利插回，flag=1表示能插入，flag=0表示不能插入
%输出deltaC：              将order插回到batch中的最佳插回插入成本
function [new_batch,flag,deltaC]=ins_batch(order,orders,batch,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
r_batch=[order batch];                                        %将order添加到batch首位
flagR=judge_batch(r_batch,orders,item_weight,capacity);       %判断一个订单分批是否满足装载量约束，1表示满足，0表示不满足
if flagR==1
    %计算将order插回到batch后的总行走距离
    s_len1=shpath(r_batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %计算将order插回到batch前的总行走距离
    s_len2=shpath(batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    flag=1;
    new_batch=r_batch;
    deltaC=s_len1-s_len2;                               %计算orde的插入成本
else
    %如果不能将order插回batch，则flag赋值为0，将new_batch赋值为batch，deltaC赋值为无穷大
    flag=0;
    new_batch=batch;
    deltaC=inf;
end
end