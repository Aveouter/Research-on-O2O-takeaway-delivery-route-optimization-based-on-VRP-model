%% 根据插入车辆序号及该路线上的插入位置，将顾客插回到破坏的配送方案中
%输入fv：              removed中最小插入成本中最大的顾客
%输入fviv：            将该顾客插回到当前配送方案的路线编号
%输入fvip：            将该顾客插回到当前配送方案的对应路线中的插入位置
%输入fvC：             该顾客的最小插入成本
%输入rfvc：            破坏后的配送方案
%输入dist：            距离矩阵
%输出ifvc：            插回顾客后的rfvc
%输出iTD：             插回顾客后的rfvc的总行驶距离
function [ifvc,iTD]=insert(fv,fviv,fvip,fvC,rfvc,dist)
ifvc=rfvc;
sumTD=travel_distance(rfvc,dist);               %插回前的总距离
iTD=sumTD+fvC;                                  %插回后的总距离
%% 如果插回车辆属于rfvc中的车辆
if fviv<=size(rfvc,1)
    route=rfvc{fviv};                           %将顾客插回的路径
    len=length(route);
    if fvip==1
        temp=[fv route];
    elseif fvip==len+1
        temp=[route fv];
    else
        temp=[route(1:fvip-1) fv route(fvip:end)];
    end
    ifvc{fviv}=temp;
%否则，新增加一辆车
else 
    ifvc{fviv,1}=[fv];
end
end