%% 找出城市i所在的路径,以及所在路径的序号
%输入visit：       城市编号
%输入RP：          当前行走方案
%输出route：       城市visit在RP中所在的路线
%输出rindex：      城市visit在RP中所在的路线序号
function [route,rindex]=tour(visit,RP)
m=size(RP,1);
for i=1:m
    r=RP{i};
    fv=find(r==visit,1,'first');   
    if ~isempty(fv)
        route=r;
        rindex=i;
        break;
    end
end
end