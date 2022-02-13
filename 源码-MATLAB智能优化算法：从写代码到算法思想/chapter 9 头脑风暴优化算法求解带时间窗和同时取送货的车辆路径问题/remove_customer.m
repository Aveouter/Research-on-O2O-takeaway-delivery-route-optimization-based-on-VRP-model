%% 将指定的顾客集合从当前解移除
%输入removed：         被移除的顾客集合
%输入VC：              配送方案
%输出rfvc：            将removed中的所有顾客从VC中移除后的解
function rfvc=remove_customer(removed,VC)
rfvc=VC;                            %移出removed中的顾客后的VC
nre=numel(removed);                 %最终被移出顾客的总数量
NV=size(VC,1);                      %所用车辆数
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
[rfvc,~]=deal_vehicles_customer(rfvc);
end