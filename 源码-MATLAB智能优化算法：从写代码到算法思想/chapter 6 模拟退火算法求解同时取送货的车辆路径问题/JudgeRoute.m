%% 判断一条配送路线上的各个点是否都满足装载量约束，1表示满足，0表示不满足
%输入route：       一条配送路线
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入cap：         车辆最大装载量
%输出flagR：       标记一条配送路线是否满足装载量约束，1表示满足，0表示不满足
function flagR=JudgeRoute(route,demands,pdemands,cap)
flagR=0;                                        %初始不满足装载量约束
[Ld,Lc]=leave_load(route,demands,pdemands);     %计算该条路径上离开配送中心和各个顾客时的装载量
overload_flag=find(Lc>cap,1,'first');           %查询是否存在车辆在离开某个顾客时违反装载量约束
%如果每个点都满足装载量约束，则将flagR赋值为1
if (Ld<=cap)&&(isempty(overload_flag))
    flagR=1;
end
end