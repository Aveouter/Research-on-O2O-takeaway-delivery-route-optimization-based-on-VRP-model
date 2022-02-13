%% 与iseed距离由小到大的排序数组
%输入start：           起（终）点城市
%输入iseed：           种子城市
%输入dist：            距离矩阵
%输出lst：             与iseed距离由小到大的排序数组
function lst=adj(start,iseed,dist)
di=dist(iseed,:);           %iseed与其他城市的距离数组
di(start)=inf;              %将iseed与起点start的距离设为无穷大
[~,lst]=sort(di);           %对di从小到大排序
end