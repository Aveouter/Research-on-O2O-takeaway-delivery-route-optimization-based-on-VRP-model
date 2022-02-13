%% 计算一个种群的目标函数值
%输出population：      灰狼种群
%输入n：               城市数目
%输入m：               旅行商数目
%输入start：           起（终）点城市
%输入dist：            距离矩阵
%输出obj：             灰狼种群的目标函数值
function obj=obj_function(population,n,m,start,dist)
NIND=size(population,1);                        %种群数目
obj=zeros(NIND,1);                              %初始化种群目标函数值
for i=1:NIND
    individual=population(i,:);                 %第i个灰狼个体
    RP=decode(individual,n,m,start);            %将第i个灰狼个体解码为旅行商行走方案
    [~,~,maxETD]=travel_distance(RP,dist);      %计算m个旅行商中行走距离的最大值
    obj(i)=maxETD;                              %将maxETD赋值给目标函数值
end
end