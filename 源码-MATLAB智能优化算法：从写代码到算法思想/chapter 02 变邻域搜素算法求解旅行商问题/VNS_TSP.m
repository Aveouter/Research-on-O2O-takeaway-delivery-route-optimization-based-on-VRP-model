tic
clear
clc
%% 输入数据
dataset=importdata('input.txt');                %数据中，每一列的含义分别为[序号，x坐标，y坐标]
x=dataset(:,2);                                 %x坐标
y=dataset(:,3);                                 %y坐标
vertexes=dataset(:,2:3);                        %提取各个城市的xy坐标
N=size(dataset,1);                              %城市数目
h=pdist(vertexes);                              %计算各个城市之间的距离，一共有1+2+......+(n-1)=n*(n-1)/2个
dist=squareform(h);                             %将各个城市之间的距离转换为n行n列的距离矩阵
%% 参数初始化
MAXGEN=50;                                      %外层最大迭代次数
M=50;                                           %最多进行M次邻域操作
n=3;                                            %邻域数目
%% 构造初始解
[init_route,init_len]=construct_route(dist);    %贪婪构造初始解
disp(['初始路线总距离为',num2str(init_len)]);
cur_route=init_route;
best_route=cur_route;
best_len=route_length(cur_route,dist);
BestL=zeros(MAXGEN,1);                          %记录每次迭代过程中全局最优个体的总距离
%% 主循环
gen=1;                                          %外层计数器
while gen<=MAXGEN
    k=1;
    while(1)
        switch k
            case 1
                cur_route=shaking(cur_route,dist,k);
                [swap_route,swap_len]=swap_neighbor(cur_route,dist,M);
                cur_len=swap_len;
                if cur_len<best_len
                    cur_route=swap_route;
                    best_len=cur_len;
                    best_route=swap_route;
                    k=0;
                end
            case 2
                cur_route=shaking(cur_route,dist,k);
                [reversion_route,reversion_len]=reversion_neighbor(cur_route,dist,M);
                cur_len=reversion_len;
                if cur_len<best_len
                    cur_route=reversion_route;
                    best_len=cur_len;
                    best_route=reversion_route;
                    k=0;
                end
            case 3
                cur_route=shaking(cur_route,dist,k);
                [insertion_route,insertion_len]=insertion_neighbor(cur_route,dist,M);
                cur_len=insertion_len;
                if cur_len<best_len
                    cur_route=insertion_route;
                    best_len=cur_len;
                    best_route=insertion_route;
                    k=0;
                end
            otherwise
                break;
        end
        k=k+1;
    end
    disp(['第',num2str(gen),'代最优路线总距离为',num2str(best_len)]);
    BestL(gen,1)=best_len;
    %% 计数器加1
    gen=gen+1;
end
%% 画出优化过程图
figure;
plot(BestL,'LineWidth',1);
title('优化过程')
xlabel('迭代次数');
ylabel('总距离');
%% 画出全局最优路线图
plot_route(best_route,x,y);
toc