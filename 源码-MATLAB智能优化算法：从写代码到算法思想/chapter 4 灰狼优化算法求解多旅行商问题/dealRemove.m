%% 将移除集合中的元素从当前解中移除
%输入removed：         被移出的城市集合
%输入RP：              旅行商行走路线方案
%输出sdestroy：        移出removed中的城市后的RP
function sdestroy=dealRemove(removed,RP)
%% 将removed中的城市从VC中移除
sdestroy=RP;                %移出removed中的城市后的RP
nre=length(removed);        %最终被移出城市的总数量
m=size(RP,1);               %旅行商数目
for i=1:m
    route=RP{i};
    for j=1:nre
        findri=find(route==removed(j),1,'first');
        if ~isempty(findri)
            route(route==removed(j))=[];
        end
    end
    sdestroy{i}=route;
end
sdestroy=deal_rp(sdestroy);
end