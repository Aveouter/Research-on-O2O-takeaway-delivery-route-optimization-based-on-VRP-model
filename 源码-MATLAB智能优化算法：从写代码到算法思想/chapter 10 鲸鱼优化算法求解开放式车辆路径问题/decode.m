%% 将鲸鱼个体解码为配送方案
%输入individual：      鲸鱼个体
%输入cusnum：          顾客数目
%输入cap：             货车最大装载量
%输入demands：         顾客需求量
%输入dist：            距离矩阵
%输出VC：              鲸鱼个体解码出的配送方案
%输出NV：              车辆使用数目
%输出TD：              车辆行驶总距离
%输出violate_num：     违反约束路径数目
%输出violate_cus：     违反约束顾客数目
function [VC,NV,TD,violate_num,violate_cus]=decode(individual,cusnum,cap,demands,dist)
violate_num=0;                                          %违反约束路径数目
violate_cus=0;                                          %违反约束顾客数目
VC=cell(cusnum,1);                                      %每辆车所经过的顾客
count=1;                                                %车辆计数器，表示当前车辆使用数目
location0=find(individual>cusnum);                      %找出个体中配送中心的位置
for i=1:length(location0)
    if i==1                                             %第1个配送中心的位置
        route=individual(1:location0(i));               %提取两个配送中心之间的路径
        route(route==individual(location0(i)))=[];      %删除路径中配送中心序号
    else
        route=individual(location0(i-1):location0(i));  %提取两个配送中心之间的路径
        route(route==individual(location0(i-1)))=[];    %删除路径中配送中心序号
        route(route==individual(location0(i)))=[];      %删除路径中配送中心序号
    end
    VC{count}=route;                                    %更新配送方案
    count=count+1;                                      %车辆使用数目
end
route=individual(location0(end):end);                   %最后一条路径       
route(route==individual(location0(end)))=[];            %删除路径中配送中心序号
VC{count}=route;                                        %更新配送方案
[VC,NV]=deal_VC(VC);                                    %将VC中空的数组移除
for j=1:NV
    route=VC{j};
    flag=JudgeRoute(route,demands,cap);                 %判断一条路线是否满足载重量约束，1表示满足，0表示不满足
    if flag==0
        violate_cus=violate_cus+length(route);          %如果这条路径不满足约束，则违反约束顾客数目加该条路径顾客数目
        violate_num=violate_num+1;                      %如果这条路径不满足约束，则违反约束路径数目加1
    end
end
TD=travel_distance(VC,dist);                            %该配送方案车辆行驶总距离
end