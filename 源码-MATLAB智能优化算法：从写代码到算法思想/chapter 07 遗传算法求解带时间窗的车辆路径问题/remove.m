%% 破坏操作，先从原有顾客集合中随机选出一个顾客，然后根据相关性再依次移出需要数量的顾客
%输入cusnum：          顾客数目
%输入toRemove：        将要移除的顾客数目
%输入D：               随机元素
%输入dist：            距离矩阵
%输入VC：              破坏前的配送方案
%输出removed：         被移除的顾客集合
%输出rfvc：            破坏后的配送方案
function [removed,rfvc]=remove(cusnum,toRemove,D,dist,VC)
inplan=1:cusnum;                    %所有顾客的集合
visit=ceil(rand*cusnum);            %随机从所有顾客中随机选出一个顾客
inplan(inplan==visit)=[];           %将被移出的顾客从原有顾客集合中移出
removed=[visit];                    %被移出的顾客集合
while length(removed)<toRemove
    nr=length(removed);             %当前被移出的顾客数量
    vr=ceil(rand*nr);               %从被移出的顾客集合中随机选择一个顾客
    nip=length(inplan);             %原来顾客集合中顾客的数量
    R=zeros(1,nip);                 %存储removed(vr)与inplan中每个元素的相关性的数组
    for i=1:nip
        R(i)=relatedness(removed(vr),inplan(i),dist,VC);   %计算removed(vr)与inplan中每个元素的相关性
    end
    [SRV,SRI]=sort(R,'descend');        
    lst=inplan(SRI);                %将inplan中的数组按removed(vr)与其的相关性从高到低排序
    vc=lst(ceil(rand^D*nip));       %从lst数组中选择一个客户
    removed=[removed vc];           %向被移出的顾客集合中添加被移出的顾客
    inplan(inplan==vc)=[];          %将被移出的顾客从原有顾客集合中移出
end
rfvc=VC;                            %移出removed中的顾客后的final_vehicles_customer
nre=length(removed);                %最终被移出顾客的总数量
NV=size(VC,1);                      %车辆使用数目
for i=1:NV
    route=VC{i};
    for j=1:nre
        findri=find(route==removed(j),1,'first');
        if ~isempty(findri)
            route(route==removed(j))=[];
        end
    end
    rfvc{i}=route;
end
rfvc=deal_VC(rfvc);
end