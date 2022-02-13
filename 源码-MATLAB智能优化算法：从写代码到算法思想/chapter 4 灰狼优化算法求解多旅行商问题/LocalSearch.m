%% 局部搜索函数
%输出individual：      灰狼个体
%输入n：               城市数目
%输入m：               旅行商数目
%输入k：               移除相邻路径的数目
%输入start：           起（终）点城市
%输入dist：            距离矩阵
%输出individual：      局部搜索后的灰狼个体
%输出ind_obj：         局部搜索后的灰狼个体的目标函数值
function [individual,ind_obj]=LocalSearch(individual,n,m,k,start,dist)
alpha_RP=decode(individual,n,m,start);                      %将灰狼个体解码为旅行商行走方案
[~,~,alpha_TD1]=travel_distance(alpha_RP,dist);             %灰狼个体的目标函数值
[removed1,sdestroy1]=remove(alpha_RP,n,m,k,start,dist);     %对灰狼个体进行移除操作
s_alpha=repair(removed1,sdestroy1,dist);                    %对灰狼个体进行修复操作
[~,~,alpha_TD2]=travel_distance(s_alpha,dist);              %灰狼个体修复后的目标函数值
%% 只有目标函数值减小，才会接受新行走方案，并转换为灰狼个体
if alpha_TD2<alpha_TD1
    individual=change(s_alpha);
end
ind_obj=obj_function(individual,n,m,start,dist);            %计算individual的目标函数值
end