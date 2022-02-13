tic
clear
clc
%% 输入数据
dataset=importdata('input.txt');                    %数据中，每一列的含义分别为[序号，x坐标，y坐标]
x=dataset(:,2);                                     %x坐标
y=dataset(:,3);                                     %y坐标
vertexs=dataset(:,2:3);                             %提取各个城市的xy坐标
n=size(dataset,1);                                  %城市数目
m=2;                                                %旅行商数目
start=1;                                            %起点城市
h=pdist(vertexs);                                   %计算各个城市之间的距离，一共有1+2+......+(n-1)=n*(n-1)/2个
dist=squareform(h);                                 %将各个城市之间的距离转换为n行n列的距离矩阵
%% 灰狼算法参数设置
NIND=50;                                            %灰狼个体数目
MAXGEN=200;                                         %最大迭代次数
k=m;                                                %移除相邻路径的数目
%% 初始化种群
population=init_pop(NIND,n,m,start);
init_obj=obj_function(population,n,m,start,dist);   %初始种群目标函数值
%% 灰狼优化
gen=1;                                              %计数器
best_alpha=zeros(MAXGEN,n+m-1);                     %记录每次迭代过程中全局最优灰狼个体
best_obj=zeros(MAXGEN,1);                           %记录每次迭代过程中全局最优灰狼个体的目标函数值

alpha_individual=population(1,:);                   %初始灰狼α个体
alpha_obj=init_obj(1);                              %初始灰狼α的目标函数值
beta_individual=population(2,:);                    %初始灰狼β个体
beta_obj=init_obj(2);                               %初始灰狼β的目标函数值
delta_individual=population(3,:);                   %初始灰狼δ个体
delta_obj=init_obj(3);                              %初始灰狼δ的目标函数值
while gen<=MAXGEN
    obj=obj_function(population,n,m,start,dist);    %计算灰狼种群目标函数值
    %% 确定当前种群中的灰狼α个体、灰狼β个体和灰狼δ个体
    for i=1:NIND
        %更新灰狼α个体
        if obj(i,1)<alpha_obj 
            alpha_obj=obj(i,1); 
            alpha_individual=population(i,:);
        end
        %更新灰狼β个体
        if obj(i,1)>alpha_obj && obj(i,1)<beta_obj 
            beta_obj=obj(i,1); 
            beta_individual=population(i,:);
        end
        %更新灰狼δ个体
        if obj(i,1)>alpha_obj && obj(i,1)>beta_obj && obj(i,1)<delta_obj 
            delta_obj=obj(i,1); 
            delta_individual=population(i,:);
        end
    end
    %% 更新当前种群中灰狼个体的位置
    for i=1:NIND
        r=rand;
        individual=population(i,:);                 %第i个灰狼个体
        %概率更新灰狼个体位置
        if r<=1/3
            new_individual=cross(individual,alpha_individual,n);
        elseif r<=2/3
            new_individual=cross(individual,beta_individual,n);
        else
            new_individual=cross(individual,delta_individual,n);
        end
        population(i,:)=new_individual;             %更新第i个灰狼个体
    end
    %% 局部搜索操作
    [alpha_individual,alpha_obj]=LocalSearch(alpha_individual,n,m,k,start,dist);
    [beta_individual,beta_obj]=LocalSearch(beta_individual,n,m,k,start,dist);
    [delta_individual,delta_obj]=LocalSearch(delta_individual,n,m,k,start,dist);
    %% 记录全局最优灰狼个体
    best_alpha(gen,:)=alpha_individual;             %记录全局最优灰狼个体
    best_obj(gen,1)=alpha_obj;                      %记录全局最优灰狼个体的目标函数值
    %% 打印当前代数全局最优解
    disp(['第',num2str(gen),'代最优解的目标函数值：',num2str(alpha_obj)])
    %% 更新计数器
    gen=gen+1;                                      %计数器加1
end
%% 打印每次迭代的全局最优灰狼个体的目标函数值变化趋势图
figure;
plot(best_obj,'LineWidth',1);
title('优化过程')
xlabel('迭代次数');
ylabel('行走总距离');
%% 将全局最优灰狼个体解码为旅行商行走路线方案
bestRP=decode(alpha_individual,n,m,start);          %将全局最优灰狼个体解码为旅行商行走方案
[bestTD,bestETD,bestMETD]=travel_distance(bestRP,dist);   %全局最优灰狼个体的目标函数值
%% 画出最终行走路线图
draw_Best(bestRP,vertexs,start);
toc