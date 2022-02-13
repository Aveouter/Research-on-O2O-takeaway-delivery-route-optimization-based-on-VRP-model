%% 最远插入启发式：将最小插入成本最大的顾客插回到当前配送方案
%输出removed：         被移除的顾客集合
%输出rfvc：            破坏后的配送方案
%输入cap：             车辆最大装载量
%输入demands：         顾客需求量
%输入a：               顾客左时间窗
%输入b：               顾客右时间窗
%输入L：               配送中心右时间窗
%输入s：               客户点的服务时间
%输入dist：            距离矩阵
%输入v：               车辆行驶速度
%输出fv：              removed中最小插入成本中最大的顾客
%输出fviv：            将该顾客插回到当前配送方案的路线编号
%输出fvip：            将该顾客插回到当前配送方案的对应路线中的插入位置
%输出fvC：             该顾客的最小插入成本
function [fv,fviv,fvip,fvC]=farthest_ins(removed,rfvc,cap,demands,a,b,L,s,dist,v)
nr=length(removed);                     %被移出的顾客的数量
outcome=zeros(nr,3);
for i=1:nr
    %[车辆序号 插入位置序号 插入成本]
    [civ,cip,C]= cheapest_ip(removed(i),rfvc,cap,demands,a,b,L,s,dist,v);
    outcome(i,1)=civ;
    outcome(i,2)=cip;
    outcome(i,3)=C;
end
[mc,mc_index]=max(outcome(:,3));
temp=outcome(mc_index,:);
fviv=temp(1,1);
fvip=temp(1,2);
fvC=temp(1,3);
fv=removed(mc_index);
end