%% 修复操作，将被移出的顾客重新插回所破坏后的配送方案
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
%输出ReIfvc：          修复后的配送方案
%输出RTD：             修复后的配送方案的总行驶距离
function [ReIfvc,RTD]=re_inserting(removed,rfvc,cap,demands,a,b,L,s,dist,v)
while ~isempty(removed)
    %% 最远插入启发式：将最小插入成本最大的顾客插回到当前配送方案
    [fv,fviv,fvip,fvC]=farthest_ins(removed,rfvc,cap,demands,a,b,L,s,dist,v);
    removed(removed==fv)=[];
    %% 根据插入点将元素插回到原始解中
    rfvc=insert(fv,fviv,fvip,fvC,rfvc,dist);
end
rfvc=deal_VC(rfvc);
ReIfvc=rfvc;
RTD=travel_distance( ReIfvc,dist);
end