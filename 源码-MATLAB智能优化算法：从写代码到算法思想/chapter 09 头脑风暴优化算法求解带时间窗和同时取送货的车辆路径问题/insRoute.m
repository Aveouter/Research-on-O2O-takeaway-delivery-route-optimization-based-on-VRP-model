%% 判断能否将一个顾客插入到一条路径中，如果能，则将该顾客插入到最佳位置（行驶距离增加最小的位置）
%输入visit         待插入顾客
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
%输出newRoute：    如果插入成功，则为新路径，如果插入失败，则为原路径
%输出flag：        标记能否将当前顾客插入到当前路径中。flag=1表示能插入，flag=0表示不能插入
%输出deltaC：      距离增量
function [newRoute,flag,deltaC]=insRoute(visit,route,demands,pdemands,cap,a,b,L,s,dist,v)
lr=numel(route);                            %当前路径上的顾客数目
%先将顾客插回到增量最小的位置
rc0=[];                                     %记录插入顾客后符合约束的路径
delta0=[];                                  %记录插入顾客后的增量
for i=1:lr+1
    if i==lr+1
        rc=[route visit];
    elseif i==1
        rc=[visit route];
    else
        rc=[route(1:i-1) visit route(i:end)];
    end
    %% 判断一条配送路线上的各个点是否都满足装载量约束和时间窗约束，1表示满足，0表示不满足
    flagR=JudgeRoute(rc,demands,pdemands,cap,a,b,s,L,dist,v);
    if flagR==1
        rc0=[rc0;rc];                                           %将合理路径存储到rc0，其中rc0与delta0对应
        dif=part_length(rc,dist)-part_length(route,dist);       %计算成本增量
        delta0=[delta0;dif];                                    %将成本增量存储到delta0
    end
end
%如果不存在合理路径
if isempty(rc0)
    flag=0;
    newRoute=route;
    deltaC=inf;
else %如果存在合理路径
    [deltaC,ind]=min(delta0);
    newRoute=rc0(ind,:);
    flag=1;
end
end