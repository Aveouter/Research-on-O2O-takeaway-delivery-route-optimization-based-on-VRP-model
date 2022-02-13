%% 求顾客i与顾客j之间的相关性
%输入i,j：             顾客
%输入dist：            距离矩阵
%输入VC：              配送方案
%输出Rij：             顾客i和顾客j的相关性
function Rij=relatedness(i,j,dist,VC)
n=size(dist,1)-1;       %顾客数量，-1是因为减去配送中心
NV=size(VC,1);          %车辆使用数目
%计算cij'
d=dist(i+1,j+1);
[md,mindex]=max((dist(i+1,2:end)));
c=d/md;
%判断i和j是否在一条路径上
V=1;                    %设初始顾客i与顾客j不在同一条路径上
for k=1:NV
    route=VC{k};        %该条路径上经过的顾客
    findi=find(route==i,1,'first');     %判断该条路径上是否经过顾客i
    findj=find(route==j,1,'first');     %判断该条路径上是否经过顾客j
    %如果findi和findj同时非空，则证明该条路径上同时经过顾客i和顾客j，则V=0
    if ~isempty(findi)&&~isempty(findj)
        V=0;
    end
end
%计算顾客i与顾客j的相关性
Rij=1/(c+V);
end