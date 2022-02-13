%% Adjacent String Removal根据当前解的情况，会从k条临近路径中的每条路径中移除l个城市
%输入RP：              旅行商行走路线方案
%输入k：               移除相邻路径的数目
%输入n：               城市数目
%输入m：               旅行商数目
%输入start：           起（终）点城市
%输入dist：            距离矩阵
%输出removed：         被移出的城市集合
%输出sdestroy：        移出removed中的城市后的RP
function [removed,sdestroy]=remove(RP,n,m,k,start,dist)
avgt=floor((n-1)/m);                        %平均每条路线上的城市数目
removed=[];                                 %被移除城市的集合
T=[];                                       %被破坏路径的集合
iseed=ceil(rand*(n-1));                     %从当前解中随机选出要被移除的城市
lst=adj(start,iseed,dist);                  %与iseed距离由小到大的排序数组
for i=1:numel(lst)
    if numel(T)<k
        [r,rindex]=tour(lst(i),RP);         %找出城市lst(i)所在路径的序号
        fr=find(T==rindex,1,'first');       %在破坏路径集合中查找是否有该路径
        %如果要破坏的路径不在T中
        if isempty(fr)
            lmax=min(numel(r)-2,avgt);              %从当前路线中最多移除的城市数目
            %只有当当前路线至少经过一个城市时（不包括起点和终点），才考虑移除城市
            if lmax>=1
                l=randi([1,lmax],1,1);              %计算在该条路径上移除的城市的数目
                Rroute=String(l,lst(i),r,start);    %从路径r中移除包含lsr(i)在内的l个连续的城市
                removed=[removed Rroute];           %将Rroute添加到removed中
                T=[T rindex];                       %将破坏的路径添加到T中
            end
        end
    else
        break;
    end
end
%% 将removed中的城市从RP中移除
sdestroy=dealRemove(removed,RP);
end