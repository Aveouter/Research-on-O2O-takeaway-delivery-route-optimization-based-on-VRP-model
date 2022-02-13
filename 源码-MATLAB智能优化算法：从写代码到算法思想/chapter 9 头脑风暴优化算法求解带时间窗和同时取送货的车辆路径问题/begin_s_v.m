%% 计算每辆车配送路线上在各个点开始服务的时间，还计算返回配送中心时间
%输入VC：          配送方案
%输入a：           顾客左时间窗
%输入s：           对顾客的服务时间
%输入dist：        距离矩阵
%输入v：           车辆行驶速度
%输出bsv：         每辆货车对所在配送路线上在各个顾客开始服务的时间以及返回配送中心时间
function bsv=begin_s_v(VC,a,s,dist,v)
n=size(VC,1);
bsv=cell(n,1);
for i=1:n
    route=VC{i};
    [bs,back]= begin_s(route,a,s,dist,v);
    bsv{i}=[bs,back];
end
end