%% 判断当前路径是否满足时间窗约束和装载量约束，0表示违反约束，1表示满足全部约束
%输入route：           当前配送路径
%输入cap：             车辆最大装载量
%输入demands：         顾客需求量
%输入a：               顾客左时间窗
%输入b：               顾客右时间窗
%输入L：               配送中心右时间窗
%输入s：               客户点的服务时间
%输入dist：            距离矩阵
%输入v：               车辆行驶速度
%输出flagR：           0表示违反约束，1表示满足全部约束
function flagR=judge_route(route,cap,demands,a,b,L,s,dist,v)
flagR=1;                            %假设满足约束
lr=length(route);                   %该条路径上顾客数目
%% 计算每辆车的装载量
Ld=leave_load(route,demands);
%如果满足装载量约束，需用进行时间窗判断
if Ld<=cap
    %% 计算该路径上在各个点开始服务的时间，还计算返回配送中心时间
    [bs,back]=begin_s(route,a,s,dist,v);
    %如果满足配送中心右时间窗约束，需用进行判断各个顾客的时间窗是否满足时间窗约束
    if back<=L
        for i=1:lr
            %一旦发现某个顾客的时间窗是否满足时间窗约束，则直接判为违反约束，将flag设为0
            if bs(i)>b(route(i))
                flagR=0;
            end
        end
    else
        %如果不满足配送中心右时间窗约束，直接判为违反约束，将flag设为0
        flagR=0;
    end
else
    %如果不满足装载量约束，不用进行时间窗判断，直接判为违反约束，将flag设为0
    flagR=0;
end
end