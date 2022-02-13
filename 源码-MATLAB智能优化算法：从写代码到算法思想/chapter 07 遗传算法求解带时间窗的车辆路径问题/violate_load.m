%% 计算当前配送方案违反的装载量约束之和
%输入VC：              配送方案
%输入demands：         顾客需求量
%输入cap：             车辆最大装载量
%输出q：               当前配送方案中各条路径违反的装载量约束之和
function q=violate_load(VC,demands,cap)
NV=size(VC,1);                      %车辆使用数目
q=0;
for i=1:NV
    route=VC{i};
    Ld=leave_load(route,demands);   %计算第i条路径上离开配送中心时的装载量
    if Ld>cap
        q=q+Ld-cap;
    end
end
end