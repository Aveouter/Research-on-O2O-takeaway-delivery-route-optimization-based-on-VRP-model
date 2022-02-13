%% 将个体解码成配送方案
%输入individual：      个体
%输入cusnum：          顾客数目
%输入cap：             车辆最大装载量
%输入demands：         顾客需求量
%输入a：               顾客左时间窗
%输入b：               顾客右时间窗
%输入L：               配送中心右时间窗
%输入s：               客户点的服务时间
%输入dist：            距离矩阵
%输入v：               车辆行驶速度
%输出VC：              配送方案
%输出NV：              车辆使用数目
%输出TD：              车辆行驶总距离
%输出violate_num：     违反约束路径数目
%输出violate_cus：     违反约束顾客数目
function [VC,NV,TD,violate_num,violate_cus]=decode(individual,cusnum,cap,demands,a,b,L,s,dist,v)
violate_num=0;                                              %违反约束路径数目
violate_cus=0;                                              %违反约束顾客数目
VC=cell(cusnum,1);                                          %每辆车所经过的顾客
count=1;                                                    %车辆计数器，表示当前车辆使用数目
location0=find(individual>cusnum);                          %找出个体中配送中心的位置
for i=1:length(location0)
    if i==1                                                 %第1个配送中心的位置
        route=individual(1:location0(i));                   %提取两个配送中心之间的路径
        route(route==individual(location0(i)))=[];          %删除路径中配送中心序号
    else
        route=individual(location0(i-1):location0(i));      %提取两个配送中心之间的路径
        route(route==individual(location0(i-1)))=[];        %删除路径中配送中心序号
        route(route==individual(location0(i)))=[];          %删除路径中配送中心序号
    end
    VC{count}=route;                                        %更新配送方案
    count=count+1;                                          %车辆使用数目
end
route=individual(location0(end):end);                       %最后一条路径       
route(route==individual(location0(end)))=[];                %删除路径中配送中心序号
VC{count}=route;                                            %更新配送方案
[VC,NV]=deal_VC(VC);                                        %将VC中空的数组移除
for j=1:NV
    route=VC{j};
    flag=judge_route(route,cap,demands,a,b,L,s,dist,v);     %判断当前方案是否满足时间窗约束和装载量约束，0表示违反约束，1表示满足全部约束
    if flag==0
        violate_cus=violate_cus+length(route);              %如果这条路径不满足约束，则违反约束顾客数目加该条路径顾客数目
        violate_num=violate_num+1;                          %如果这条路径不满足约束，则违反约束路径数目加1
    end
end
TD=travel_distance(VC,dist);                                %该方案车辆行驶总距离
end