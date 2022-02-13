%% 判断一条配送路线上的各个点是否都满足装载量约束和时间窗约束，1表示满足，0表示不满足
%输入route：       一条配送路线
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入cap：         车辆最大装载量
%输入a：           顾客时间窗开始时间[a[i],b[i]]
%输入b：           顾客时间窗结束时间[a[i],b[i]]
%输入L：           配送中心时间窗结束时间
%输入s：           客户点的服务时间
%输入dist：        距离矩阵
%输入v：           车辆行驶速度
%输出flagR：       标记一条配送路线是否满足装载量约束，1表示满足，0表示不满足
function flagR=JudgeRoute(route,demands,pdemands,cap,a,b,s,L,dist,v)
flagR=1;                                        %初始满足装载量约束
lr=numel(route);                                %该条路径上顾客数目
[Ld,Lc]=leave_load(route,demands,pdemands);     %计算该条路径上离开配送中心和各个顾客时的装载量
overload_flag=find(Lc>cap,1,'first');           %查询是否存在车辆在离开某个顾客时违反装载量约束
%如果每个点都满足装载量约束，则还需继续判断是否满足时间窗约束。否则，不满足装载量约束，直接将flagR设为0
if (Ld<=cap)&&(isempty(overload_flag))
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
    flagR=0;
end
end