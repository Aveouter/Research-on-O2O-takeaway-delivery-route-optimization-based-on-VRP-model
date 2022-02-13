%% 计算removed中每个顾客的最小插入成本，及对应的插入路线编号和该路线上的插入位置
%输入rv：              removed集合中的任一个元素
%输出rfvc：            破坏后的配送方案
%输入cap：             车辆最大装载量
%输入demands：         顾客需求量
%输入a：               顾客左时间窗
%输入b：               顾客右时间窗
%输入L：               配送中心右时间窗
%输入s：               客户点的服务时间
%输入dist：            距离矩阵
%输入v：               车辆行驶速度
%输出civ：             将rv插入到rfvc中在满足约束下的插入成本最小的路线编号
%输出cip：             插回到对应路线上的插入位置
%输出C：               rv的最小插入成本
function [civ,cip,C]= cheapest_ip(rv,rfvc,cap,demands,a,b,L,s,dist,v)
NV=size(rfvc,1);                    %车辆使用数目
outcome=[];                         %存储每一个合理的插入点以及对应的距离增量 [车辆序号 插入位置序号 插入成本]
for i=1:NV
    route=rfvc{i};                  %第i条路径
    len=length(route);              %该路径上所经过顾客数目
    LB=part_length(route,dist);     %插入rv之前该条路径的距离
    %先将rv插入到route中的任何空隙，共(len+1)个,
    for j=1:len+1;
        %将rv插入到配送中心后
        if j==1
            temp_r=[rv route];
            LA=part_length(temp_r,dist);    %插入rv之后该条路径的距离
            delta=LA-LB;                    %插入rv之后该条路径的距离增量
            %判断当前路径是否满足时间窗约束和载重量约束，0表示违反约束，1表示满足全部约束
            flagR=judge_route(temp_r,cap,demands,a,b,L,s,dist,v);    
            %如果同时满足时间窗约束和容量约束，则该插入点合理，并记录下来
            if flagR==1
                outcome=[outcome;i j delta];
            end
            %将rv插入到配送中心前
        elseif j==len+1
            temp_r=[route rv];
            LA=part_length(temp_r,dist);       %插入rv之后该条路径的距离
            delta=LA-LB;                       %插入rv之后该条路径的距离增量
            %判断当前路径是否满足时间窗约束和载重量约束，0表示违反约束，1表示满足全部约束
            flagR=judge_route(temp_r,cap,demands,a,b,L,s,dist,v);    
            %如果同时满足时间窗约束和容量约束，则该插入点合理，并记录下来
            if flagR==1
                outcome=[outcome;i j delta];
            end
            %将rv插入到顾客之间的任意空隙
        else
            temp_r=[route(1:j-1) rv route(j:end)];
            LA=part_length(temp_r,dist);       %插入rv之后该条路径的距离
            delta=LA-LB;                       %插入rv之后该条路径的距离增量
            %判断当前路径是否满足时间窗约束和载重量约束，0表示违反约束，1表示满足全部约束
            flagR=judge_route(temp_r,cap,demands,a,b,L,s,dist,v);    
            %如果同时满足时间窗约束和容量约束，则该插入点合理，并记录下来
            if flagR==1
                outcome=[outcome;i j delta];
            end
        end
    end
end
%% 如果存在合理的插入点，则找出最优插入点，否在新增加一辆车运输
if ~isempty(outcome)
    addC=outcome(:,3);                          %每个插入点的距离增量
    [saC,sindex]=sort(addC);                    %将距离增量从小到达排序
    temp=outcome(sindex,:);                     %将距离增量从小到达排序后的[车辆序号 插入位置序号 插入成本]
    civ=temp(1,1);                              %第一行即为最佳插入点以及对应的距离增量
    cip=temp(1,2);
    C=temp(1,3);
else
    civ=NV+1;
    cip=1;
    C=part_length(rv,dist);
end
end