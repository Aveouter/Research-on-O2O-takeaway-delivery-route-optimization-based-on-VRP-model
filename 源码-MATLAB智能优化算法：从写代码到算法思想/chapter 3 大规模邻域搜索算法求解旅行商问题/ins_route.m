%% 将visit插回到插入成本最小的位置后的路线，同时还计算出插入到各个插入位置的插入成本
%输入visit：               待插入的城市
%输入dist：                距离矩阵
%输入route：               被插入路径
%输出new_route：           将visit插入到route最小插入成本位置后的解
%输出up_delta：            将visit插入到route中各个插入位置后的插入成本从小到大排序后的结果
function [new_route,up_delta]=ins_route(visit,dist,route)
lr=numel(route);                            %当前路线城市数目
rc0=zeros(lr+1,lr+1);                       %记录插入城市后的路径
delta0=zeros(lr+1,1);                       %记录插入城市后的增量
for i=1:lr+1
    if i==lr+1
        rc=[route visit];
    elseif i==1
        rc=[visit route];
    else
        rc=[route(1:i-1) visit route(i:end)];
    end
    rc0(i,:)=rc;                                            %将合理路径存储到rc0，其中rc0与delta0对应
    dif=route_length(rc,dist)-route_length(route,dist);     %计算成本增量
    delta0(i,1)=dif;                                        %将成本增量存储到delta0
end
up_delta=sort(delta0);                                      %将插入成本从小到大排序
[~,ind]=min(delta0);                                        %计算最小插入成本所对应的序号
new_route=rc0(ind,:);                                        %最小插入成本所对应的插入后的路径
end