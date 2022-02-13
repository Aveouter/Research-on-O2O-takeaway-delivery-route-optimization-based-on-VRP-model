%% 计算货车在配送路线上货车对各个顾客开始服务的时间和返回配送中心时间
%输入VC：              配送方案
%输入a：               顾客左时间窗
%输入s：               客户点的服务时间
%输入dist：            距离矩阵
%输入v：               车辆行驶速度
%输出bsv：             货车在配送路线上货车对各个顾客开始服务的时间和返回配送中心时间
function bsv= begin_s_v(VC,a,s,dist,v)
n=size(VC,1);           %车辆使用数目
bsv=cell(n,1);
for i=1:n
    route=VC{i};
    %计算货车在配送路线上货车对各个顾客开始服务的时间和返回配送中心时间
    [bs,back]=begin_s(route,a,s,dist,v);
    bsv{i}=[bs,back];
end
end