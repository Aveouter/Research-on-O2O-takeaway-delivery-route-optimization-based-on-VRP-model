%% 计算当前配送方案的目标函数值
%输入VC：          当前配送方案
%输入dist：        距离矩阵
%输入demands：     各个顾客需求量
%输入cap：         车辆最大装载量
%输入belta：       违反装载量约束的惩罚函数系数
%输出cost：        当前配送方案的目标函数值
function cost=costFuction(VC,dist,demands,cap,belta)
TD=travel_distance(VC,dist);            %计算当前配送方案的总行驶距离
q=violateLoad(VC,demands,cap);          %计算各条配送路线上货车离开配送中心时违反的容量约束之和
cost=TD+belta*q;                        %计算当前配送方案的目标函数值
end