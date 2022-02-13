%% 修复函数repair依次将removed中的城市插回路径中
%先计算removed中各个城市插回当前解中所产生最小增量，然后再从上述各个最小增量的城市中
%找出一个(距离增量第2小-距离增量第1小)最大的城市插回，反复执行，直到全部插回
%输入removed：                 被移除城市的集合
%输入Sdestroy：                “破坏”后的解
%输入dist：                    距离矩阵
%输出Srepair：                 “修复”后的解
%输出repair_length：           Srepair的总距离
function [Srepair,repair_length]=repair(removed,Sdestroy,dist)
Srepair=Sdestroy;
%反复插回removed中的城市，直到全部城市插回
while ~isempty(removed)
    nr=numel(removed);                                  %移除集合中城市数目
    regret=zeros(nr,1);                                 %存储removed各城市插回最“好”插回路径后的遗憾值增量
    %逐个计算removed中的城市插回当前解中各路径的目标函数值增
    for i=1:nr
        visit=removed(i);                               %当前要插回的城市
        [~,up_delta]=ins_route(visit,dist,Srepair);     %将visit插回到插入成本最小的位置后的路线，同时还计算出插入到各个插入位置的插入成本
        de12=up_delta(2)-up_delta(1);                   %计算第2小成本增量与第1小成本增量差值
        regret(i)=de12;                                 %更新当前城市插回最“好”插回路径后的遗憾值
    end
    [~,max_index]=max(regret);                          %找出遗憾值最大的城市序号
    reinsert_city=removed(max_index);                   %removed中准备插回的城市
    Srepair=ins_route(reinsert_city,dist,Srepair);      %将reinsert_city插回到Srepair
    removed(max_index)=[];                              %将removed(firIns)城市从removed中移除
end
repair_length=route_length(Srepair,dist);               %计算Srepair的总距离
end