%% Remove操作，先从原有顾客集合中随机选出一个顾客，然后根据相关性再依次移出需要数目的顾客
%输入cusnum：      顾客数目
%输入toRemove：    将要移出顾客的数目
%输入D：           随机元素
%输入dist：        距离矩阵
%输入VC：          配送方案，即每辆车所经过的顾客
%removed：         被移出的顾客集合
%rfvc：            移出removed中的顾客后的VC
function [removed,rfvc]=Remove(cusnum,toRemove,D,dist,VC)
%% Remove
inplan=1:cusnum;            %所有顾客的集合
visit=ceil(rand*cusnum);    %随机从所有顾客中随机选出一个顾客
inplan(inplan==visit)=[];   %将被移出的顾客从原有顾客集合中移出
removed=[visit];            %被移出的顾客集合
while length(removed)<toRemove
    nr=length(removed);             %当前被移出的顾客数目
    vr=ceil(rand*nr);               %从被移出的顾客集合中随机选择一个顾客
    nip=length(inplan);             %原来顾客集合中顾客的数目
    R=zeros(1,nip);                 %存储removed(vr)与inplan中每个元素的相关性的数组
    for i=1:nip
        R(i)=Relatedness(removed(vr),inplan(i),dist,VC);   %计算removed(vr)与inplan中每个元素的相关性
    end
    [SRV,SRI]=sort(R,'descend');        
    lst=inplan(SRI);                %将inplan中的数组按removed(vr)与其的相关性从高到低排序
    vc=lst(ceil(rand^D*nip));       %从lst数组中选择一个客户
    removed=[removed vc];           %向被移出的顾客集合中添加被移出的顾客
    inplan(inplan==vc)=[];          %将被移出的顾客从原有顾客集合中移出
end
rfvc=remove_customer(removed,VC);   %将removed中的所有顾客从VC中移除后的解
end