%% 计算当前解的成本函数
%输入VC：          配送方案，即每辆车所经过的顾客
%输入dist：        距离矩阵
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入cap：         车辆最大装载量
%输入belta：       违反的装载量约束的惩罚系数
%输出cost：        当前配送方案的总成本 f=TD+belta*q
function cost=costFuction(VC,dist,demands,pdemands,cap,belta)
TD=travel_distance(VC,dist);
q=violateLoad(VC,demands,pdemands,cap);
cost=TD+belta*q;
end