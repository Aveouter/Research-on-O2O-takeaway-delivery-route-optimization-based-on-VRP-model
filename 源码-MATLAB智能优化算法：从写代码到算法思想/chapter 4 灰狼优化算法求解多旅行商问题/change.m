%% 行走方案与灰狼个体之间进行转换
%输入RP：          旅行商行走路线方案
%输出individual：  灰狼个体
function individual=change(RP)
m=size(RP,1);                   %旅行商数目
individual=[];
lr=zeros(1,m);                  %每个旅行商所服务的城市数目
for i=1:m
    route=RP{i};
    start=route(1);
    route(route==start)=[];
    lr(i)=numel(route);
    individual=[individual,route];
end
individual=[individual,lr];
end