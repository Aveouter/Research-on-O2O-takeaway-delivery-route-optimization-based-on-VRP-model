%% 计算将当前城市插回到当前路线中“插入成本”最小的位置
%输入visit         待插入城市
%输入route：       一条行走路线
%输入dist：        距离矩阵
%输出newRoute：    将visit插入到当前路线最佳位置后的行走路线
%输出deltaC：      将visit插入到当前路线最佳位置后的插入成本
function [newRoute,deltaC]=insRoute(visit,route,dist,maxETD)
start=route(1);                             %起（终）点城市
rcopy=route;                                %复制路线
rcopy(rcopy==start)=[];                     %将start从rcopy中删除
lr=numel(route)-2;                          %除去起点城市和终点城市外，当前路径上的城市数目
%先将城市插回到增量最小的位置
rc0=[];                                     %记录插入城市后符合约束的路径
delta0=[];                                  %记录插入城市后的增量
for i=1:lr+1
    if i==lr+1
        rc=[start,rcopy,visit,start];
    elseif i==1
        rc=[start,visit,rcopy,start];
    else
        rc=[start,rcopy(1:i-1),visit,rcopy(i:end),start];
    end
    rc0=[rc0;rc];                           %将路径存储到rc0，其中rc0与delta0对应
    alen=route_length(rc,dist);
    dif=alen-maxETD;                        %计算插入成本
    delta0=[delta0;dif];                    %将插入成本存储到delta0
end
[deltaC,ind]=min(delta0);
newRoute=rc0(ind,:);
end