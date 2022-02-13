%% 从种群中选出目标函数值在前10%的个体
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
%输出offspring：           目标函数值在前10%的萤火虫个体
function offspring=select(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha)
NIND=size(Population,1);                    %种群数目
Obj=obj_function(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
[~,index]=sort(Obj);                        %将种群按照目标函数值从小到大的顺序进行排序
off_num=ceil(NIND*0.1);                     %选择出的后代个体数目
offspring=Population(index(1:off_num),:);   %选择出的后代个体
end