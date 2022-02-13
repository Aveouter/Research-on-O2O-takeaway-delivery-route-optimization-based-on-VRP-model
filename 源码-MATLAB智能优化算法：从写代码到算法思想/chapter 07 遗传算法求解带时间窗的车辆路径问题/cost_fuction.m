%% 计算当前配送方案的总成本
%输入VC：              配送方案
%输入a：               顾客左时间窗
%输入b：               顾客右时间窗
%输入s：               客户点的服务时间
%输入L：               配送中心右时间窗
%输入dist：            距离矩阵
%输入demands：         顾客需求量
%输入cap：             车辆最大装载量
%输入alpha：           违反的容量约束的惩罚函数系数
%输入belta：           违反时间窗约束的惩罚函数系数
%输入v：               车辆行驶速度
%输出cost：            当前配送方案总成本 f=TD+alpha*q+belta*w
function cost=cost_fuction(VC,a,b,s,L,dist,demands,cap,alpha,belta,v)
TD=travel_distance(VC,dist);        %计算当前配送方案总行驶距离
q=violate_load(VC,demands,cap);     %计算当前配送方案中各条路径违反的装载量约束之和
w=violateTW(VC,a,b,s,L,dist,v);     %计算当前配送方案中所有顾客违反的时间窗约束之和
cost=TD+alpha*q+belta*w;            %计算当前配送方案总成本
end