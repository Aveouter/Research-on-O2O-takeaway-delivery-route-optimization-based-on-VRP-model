%% 计算当前配送方案违反装载量约束之和
%输入VC：          配送方案，即每辆车所经过的顾客
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入cap：         车辆最大装载量
%输出q：           各条配送路线违反装载量约束之和
function q=violateLoad(VC,demands,pdemands,cap)
NV=size(VC,1);                     %所用车辆数目
q=0;
for i=1:NV
    route=VC{i};
    n=numel(route);
    [Ld,Lc]=leave_load(route,demands,pdemands);
    if Ld>cap
        q=q+Ld-cap;
    end
    for j=1:n
        if Lc(j)>cap
            q=q+Lc(j)-cap;
        end
    end
end
end