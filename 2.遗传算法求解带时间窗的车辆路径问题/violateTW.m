%% 计算当前配送方案中所有顾客违反的时间窗约束之和
%输入VC：              配送方案
%输入a：               顾客左时间窗
%输入b：               顾客右时间窗
%输入s：               客户点的服务时间
%输入L：               配送中心右时间窗
%输入dist：            距离矩阵
%输入v：               车辆行驶速度
%输出w：               当前配送方案中所有顾客违反的时间窗约束之和
function w=violateTW(VC,a,b,s,L,dist,v)
NV=size(VC,1);                              %车辆使用数目
w=0;
bsv=begin_s_v(VC,a,s,dist,v);               %计算货车在配送路线上货车对各个顾客开始服务的时间和返回配送中心时间
%% 只有晚于右时间窗到达才算违反时间窗约束
for i=1:NV
    route=VC{i};
    bs=bsv{i};
    l_bs=length(bsv{i});
    for j=1:l_bs-1
        if bs(j)>b(route(j))
            w=w+bs(j)-b(route(j));
        end
    end
    if bs(end)>L
        w=w+bs(end)-L;
    end
end
end