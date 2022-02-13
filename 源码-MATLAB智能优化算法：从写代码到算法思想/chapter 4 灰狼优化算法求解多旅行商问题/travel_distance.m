%% 计算所有旅行商的行走总距离、每个旅行商的行走距离、以及各旅行商的行走距离的最大值
%输入RP：              旅行商行走路线方案
%输入dist：            距离矩阵
%输出sumTD：           所有旅行商的行走总距离
%输出everyTD：         每个旅行商的行走距离
%输出maxETD：          everyTD中的最大值
function [sumTD,everyTD,maxETD]=travel_distance(RP,dist)
m=size(RP,1);                       %旅行商数目
everyTD=zeros(m,1);                 %初始化每个旅行商的行走距离
for i=1:m
    route=RP{i};                    %每个旅行商的行走路线
    everyTD(i)=route_length(route,dist);
end
sumTD=sum(everyTD);                 %所有旅行商的行走总距离
maxETD=max(everyTD);                %everyTD中的最大值
end