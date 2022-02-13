tic
clear
clc
%% 输入数据
dataset=importdata('input.txt');                %数据中，每一列的含义分别为[序号，x坐标，y坐标]
x=dataset(:,2);                                 %x坐标
y=dataset(:,3);                                 %y坐标
vertexes=dataset(:,2:3);                        %提取各个城市的xy坐标
h=pdist(vertexes);
dist=squareform(h);                             %距离矩阵
%% 参数初始化
MAXGEN=300;                                     %最大迭代次数
%% 构造初始解
[Sinit,init_len]=construct_route(dist);         %贪婪构造初始解
init_length=route_length(Sinit,dist);
str1=['初始总路线长度 =  ' num2str(init_length)];
disp(str1)
%% 初始化当前解和全局最优解
Scurr=Sinit;
curr_length=init_length;
Sbest=Sinit;
best_length=init_length;
%% 主循环
gen=1;
BestL=zeros(MAXGEN,1);                          %记录每次迭代过程中全局最优个体的总距离
while gen<=MAXGEN
    %% “破坏”解
    [Sdestroy,removed]=destroy(Scurr);
    %% “修复”解
    [Srepair,repair_length]=repair(removed,Sdestroy,dist);
    if repair_length<curr_length
        Scurr=Srepair;
        curr_length=repair_length;
    end
    if curr_length<best_length
        Sbest=Scurr;
        best_length=curr_length;  
    end
    %% 打印当前代全局最优解
    disp(['第',num2str(gen),'代最优路线总长度 =  ' num2str(best_length)])
    BestL(gen,1)=best_length;
    %% 计数器加1
    gen=gen+1;
end
str2=['搜索完成！ 最优路线总长度 =  ' num2str(best_length)];
disp(str2)
%% 画出优化过程图
figure;
plot(BestL,'LineWidth',1);
title('优化过程')
xlabel('迭代次数');
ylabel('总距离');
%% 画出全局最优路线图
plot_route(Sbest,x,y);
toc