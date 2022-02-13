%% 将蚂蚁构建的完整路径转换为配送方案
%输入route_k：             蚂蚁k构建的完整路径
%输入cap：                 最大装载量
%输入demands：             需求量
%输入dist：                距离矩阵，满足三角关系，暂用距离表示花费c[i][j]=dist[i][j]
%输出VC：                  配送方案，每辆车所经过的顾客
%输出NV：                  车辆使用数目
%输出TD：                  车辆行驶总距离
%
%思路：例子：当前一只蚂蚁构建的完整路径为53214，
%那么首先从头开始遍历，第一条路径为5，然后依次将3添加到这条路径，
%则该条路径变为53，此时要检验53这条路径是否满足时间窗约束和装载量约束，
%如不满足其中任何一个约束，则需要新建路径，则3为一个顾客，然后按照这种方法添加。
%如果满足上述两个约束，则继续将2添加到53这条路径，然后继续检验532这条路径是否满足时间窗约束和装载量约束，
%依此类推。
function [VC,NV,TD]=decode(route_k,cap,demands,dist)
route_k(route_k==0)=[];                             %将0从蚂蚁k的路径记录数组中删除
cusnum=size(route_k,2);                             %已服务的顾客数目
VC=cell(cusnum,1);                                  %每辆车所经过的顾客
count=1;                                            %车辆计数器，表示当前车辆使用数目
preroute=[];                                        %存放某一条路径
for i=1:cusnum
    preroute=[preroute,route_k(i)];                 %将第route_k(i)添加到路径中
    flag=JudgeRoute(preroute,demands,cap);          %判断一条路线是否满足装载量约束，1表示满足，0表示不满足
    if flag==1
        %如果满足约束，则更新车辆配送方案VC
        VC{count}=preroute;               
    else
        %如果满足约束，则清空preroute，并使count加1
        preroute=route_k(i);     
        count=count+1;
        VC{count}=preroute;     
    end
end
VC=deal_vehicles_customer(VC);                     %将VC中空的数组移除
NV=size(VC,1);                                     %车辆使用数目
TD=travel_distance(VC,dist);
end