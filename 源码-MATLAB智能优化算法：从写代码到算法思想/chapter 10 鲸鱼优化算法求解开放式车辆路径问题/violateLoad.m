%% 计算当前配送方案违反的装载量约束之和
%输入VC：              当前配送方案
%输入demands：         各个顾客需求量
%输入cap：             车辆最大装载量
%输出q                 各条配送路线违反装载量之和
function q=violateLoad(VC,demands,cap)
NV=size(VC,1);         %车辆使用数目
q=0;
for i=1:NV
    route=VC{i};
    Ld=leave_load(route,demands);
    if Ld>cap
        q=q+Ld-cap;
    end
end
end