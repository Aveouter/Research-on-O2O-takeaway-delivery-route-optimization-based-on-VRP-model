%% 计算当前配送方案的成本函数
%输入VC：          每辆车所经过的顾客
%输入a,b：         顾客时间窗结束时间[a[i],b[i]]
%输入s：           对每个顾客的服务时间
%输入L：           配送中心时间窗结束时间
%输入dist：        距离矩阵
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入cap：         车辆最大装载量
%输入alpha：       违反的装载量约束的惩罚函数系数
%输入belta：       违反时间窗约束的惩罚函数系数
%输入v：           车辆行驶速度
%输出cost：        总成本 f=TD+alpha*q+belta*w
function cost=costFuction(VC,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v)
TD=travel_distance(VC,dist);
q=violateLoad(VC,demands,pdemands,cap);
w=violateTW(VC,a,b,s,L,dist,v);
cost=TD+alpha*q+belta*w;
end