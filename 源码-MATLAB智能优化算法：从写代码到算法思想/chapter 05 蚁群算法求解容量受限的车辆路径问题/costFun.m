%% 计算一个配送方案的总成本=车辆行驶总距离
%输入VC：          配送方案
%输入dist：        距离矩阵
%输出cost：        该配送方案的总成本
%输出NV：          车辆使用数目
%输出TD：          车辆行驶总距离
function [cost,NV,TD]=costFun(VC,dist)
NV=size(VC,1);                      %车辆使用数目
TD=travel_distance(VC,dist);        %行驶总距离
cost=TD;
end