%% 判断一条配送路线是否满足装载量约束，1表示满足，0表示不满足
%输入route：       一条配送路线
%输入demands：     顾客需求量
%输入cap：         货车最大装载量
%输出flagR：       标记一条路线是否满足装载量约束，1表示满足，0表示不满足
function flagR=JudgeRoute(route,demands,cap)
flagR=1;                        %初始满足装载量约束
Ld=leave_load(route,demands);   %计算该条路径上离开配送中心时的装载量
%如果不满足装载量约束，则将flagR赋值为0
if Ld>cap
    flagR=0;
end
end