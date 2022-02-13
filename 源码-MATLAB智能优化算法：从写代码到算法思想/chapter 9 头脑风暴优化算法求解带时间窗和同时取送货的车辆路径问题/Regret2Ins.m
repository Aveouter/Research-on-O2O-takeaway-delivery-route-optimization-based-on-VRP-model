%% Regret2Ins 依次将removed中的顾客插回配送方案中
%先计算removed中各个顾客插回当前解中所产生最小距离增量，然后再从上述各个最小距离增量的顾客中
%找出一个(距离增量第2小-距离增量第1小)最大的顾客插回，反复执行，直到全部插回
%输入removed：     被移除顾客的集合
%rfvc：            破坏后的配送方案
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入cap：         车辆最大装载量
%输入a：           顾客时间窗开始时间[a[i],b[i]]
%输入b：           顾客时间窗结束时间[a[i],b[i]]
%输入L：           配送中心时间窗结束时间
%输入s：           客户点的服务时间
%输入dist：        距离矩阵
%输入v：           车辆行驶速度
%repFvc：          修复后的配送方案
function repFvc=Regret2Ins(removed,rfvc,demands,pdemands,cap,a,b,L,s,dist,v)
rfvcp=rfvc;             %复制部分解
%反复插回removed中的顾客，直到全部顾客插回
while ~isempty(removed)
    nr=length(removed);     %移除集合中顾客数目
    ri=zeros(nr,1);         %存储removed各顾客最“好”插回路径
    rid=zeros(nr,1);        %存储removed各顾客插回最“好”插回路径后的遗憾值增量
    NV=size(rfvcp,1);           %当前解所用车辆数目
    %逐个计算removed中的顾客插回当前解中各路径的目标函数值增
    for i=1:nr
        visit=removed(i);           %当前要插回的顾客
        dec=[];                     %对应于rc的成本节约值
        ins=[];                     %记录可以插回路径的序号
        for j=1:NV
            route=rfvcp{j};          %当前路径
            %% 判断能否将一个顾客插入到一条路径中，如果能，则将该顾客插入到最佳位置（目标函数增加最小的位置）
            [~,flag,deltaC]=insRoute(visit,route,demands,pdemands,cap,a,b,L,s,dist,v);
            %flag=1表示能插入，flag=0表示不能插入
            if flag==1
                dec=[dec;deltaC];
                ins=[ins;j];
            end
        end
        %如果存在符合约束的插回路径，则找出记录遗憾值以及对应的路径
        if ~isempty(ins)
            [sd,sdi]=sort(dec);                 %将dec升序排列
            insc=ins(sdi);                      %将ins的序号与dec排序后的序号对应
            ri(i)=insc(1);                      %更新当前顾客最“好”插回路径
            if size(ins)>1
                de12=sd(2)-sd(1);                   %计算第2小成本增量与第1小成本增量差值
                rid(i)=de12;                        %更新当前顾客插回最“好”插回路径后的遗憾值
            else
                de12=sd(1);                   %计算第2小成本增量与第1小成本增量差值
                rid(i)=de12;                        %更新当前顾客插回最“好”插回路径后的遗憾值
            end
        else    %如果不存在符合约束的路径，则新建路径
            temp=[visit];
            ri(i)=NV+1;
            rid(i)=part_length(temp,dist);
        end
    end
    %根据rid  rid最大的顾客就是先插回的顾客
    [~,firIns]=max(rid);            %找出遗憾值最大的顾客序号
    readyV=removed(firIns);          %removed中准备插回的顾客
    rIns=ri(firIns);                %插回路径序号
    %如果插回路径为新建路径
    if rIns==NV+1
        temp=readyV;
        %新建路径，并将removed(firIns)插到该路径中
        rfvcp{rIns,1}=temp;
        %将removed(firIns)顾客从removed中移除
        removed(firIns)=[];
    else
        %将firIns插回到rIns
        rfvcp{rIns,1}=insRoute(removed(firIns),rfvcp{rIns,1},demands,pdemands,cap,a,b,L,s,dist,v);
        %将removed(firIns)顾客从removed中移除
        removed(firIns)=[];
    end
end
repFvc=rfvcp;
end