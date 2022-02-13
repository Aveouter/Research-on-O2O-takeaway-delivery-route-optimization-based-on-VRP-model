%% 计算种群中每个萤火虫的目标函数值
%输入Population：          种群
%输入orders：              每个订单所包含的物品信息
%输入batches_maxnum：      最大允许分批的数目
%输入orders_num：          订单数目
%输入capacity：            设备最大装载量
%输入item_weight：         每个储位品项的重量
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输入alpha：               违反设备装载量约束的惩罚因子
%输出Obj：                 种群中每个萤火虫的目标函数值
function Obj=obj_function(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha)
NIND=size(Population,1);                %萤火虫数目
Obj=size(NIND,1);                       %初始化目标函数值
for i=1:NIND
    Individual=Population(i,:);         %第i个萤火虫
    batches=decode(Individual,orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);           %解码
    Obj(i,1)=cost_function(batches,orders,item_weight,capacity,side_num,depot_leftAisle,...
        enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);                              %为第i个萤火虫目标函数值赋值  
end
end