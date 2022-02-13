%% 修复函数，依次将removed中的城市插回到行走方案中
%先计算removed中各个城市插回当前解中所产生的“插入成本”，然后再从上述各个城市中
%找出一个遗憾值(即插入成本第2小-入成本第1小)最大的城市插回，反复执行，直到全部插回
%输入removed：     被移除城市的集合
%输入sdestroy：    破坏后的行走路线方案
%输入dist：        距离矩阵
%输出srepairc：    修复后的行走方案
function srepair=repair(removed,sdestroy,dist)
srepair=sdestroy;                   %初始将破坏后的解赋值给修复解
%% 反复插回removed中的城市，直到全部城市插回
while ~isempty(removed)
    [~,~,maxETD]=travel_distance(srepair,dist);    %计算当前解的各条路线的行走距离的最大值
    nr=numel(removed);              %移除集合中城市数目
    ri=zeros(nr,1);                 %存储removed各城市最好插回路径
    rid=zeros(nr,1);                %存储removed各城市插回最好插回路径后的遗憾值
    m=size(srepair,1);              %当前解的旅行商数目
    %逐个计算将removed中的城市插回当前解中各位置后的插入成本
    for i=1:nr
        visit=removed(i);           %当前要插回的城市
        dec=[];                     %对应于将当前城市插回到当前解各路径后的最小插入成本
        ins=[];                     %记录可以插回路径的序号
        for j=1:m
            route=srepair{j};         %当前路径 
            [~,deltaC]=insRoute(visit,route,dist,maxETD);
            dec=[dec;deltaC];
            ins=[ins;j];
        end
        [sd,sdi]=sort(dec);         %将dec升序排列
        insc=ins(sdi);              %将ins的序号与dec排序后的序号对应
        ri(i)=insc(1);              %更新当前城市最好插回路径
        if size(dec,1)>1
            de12=sd(2)-sd(1);           %计算将当前城市插回到当前解的遗憾值
            rid(i)=de12;                %更新当前城市插回最“好”插回路径后的遗憾值
        else
            de12=sd(1);                   %计算第2小成本增量与第1小成本增量差值
            rid(i)=de12;                        %更新当前城市插回最“好”插回路径后的遗憾值
        end
    end
    %根据rid  rid最大的城市就是先插回的城市
    [~,firIns]=max(rid);            %找出遗憾值最大的城市序号
    rIns=ri(firIns);                %插回路径序号
    %将firIns插回到rIns
    srepair{rIns,1}=insRoute(removed(firIns),srepair{rIns,1},dist,maxETD);
    %将removed(firIns)城市从removed中移除
    removed(firIns)=[];
end
end