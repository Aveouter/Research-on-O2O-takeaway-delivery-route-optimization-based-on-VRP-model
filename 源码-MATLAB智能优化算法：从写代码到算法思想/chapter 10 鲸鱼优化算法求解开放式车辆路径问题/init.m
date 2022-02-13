%% 构造OVRP初始解
%输入cusnum：          顾客数目
%输入demands：         顾客需求量
%输入cap：             车辆最大装载量
%输入dist：            距离矩阵
%输出init_vc：         初始解
function init_vc=init(cusnum,demands,cap,dist)
%先将距离矩阵主对角线上的0赋值为无穷大
for i=1:cusnum+1
    for j=1:cusnum+1
        if i==j
            dist(i,j)=inf;
        end
    end
end
k=1;                                    %使用车辆数目，初始设置为1
init_vc=cell(k,1);
visited=[];                             %初始被访问顾客的集合
unvisited=1:cusnum;                     %初始未被访问顾客的集合
% 开始遍历
route=[];                               %存储每条路径上的顾客
load=0;                                 %初始路径上在配送中心的装载量为0
while ~isempty(unvisited)
    %如果当前路线非空
    if ~isempty(route)
        %如果当前路线为空，则从unvisited中找出离配送中心最近的顾客
        pre_dist=dist(route(end),:);    %当前路线末尾顾客与其它顾客的距离
        pre_dist(1)=inf;                %将当前路线末尾顾客与配送中心之间的距离设位无穷大
        pre_dist(visited+1)=inf;        %将当前路线末尾顾客与已经添加进来的顾客之间的距离设位无穷大
        [~,pre_point]=min(pre_dist);    %找出pre_dist中的最小值
        pre_point=pre_point-1;          %因为配送中心在第一位，所以顾客序号需要减1
    else
        %如果当前路线为空，则从unvisited中找出离配送中心最近的顾客
        pre_dist=dist(1,:);             %配送中心与其它顾客的距离
        pre_dist(visited+1)=inf;        %将pre_point与已经添加进来的顾客之间的距离设位无穷大
        [~,pre_point]=min(pre_dist);    %找出pre_dist中的最小值
        pre_point=pre_point-1;          %因为配送中心在第一位，所以顾客序号需要减1
        unvisited(unvisited==pre_point)=[]; %将pre_point从unvisit中删除
        visited=[visited,pre_point];        %把pre_point添加到visit中
    end
    %如果没有超过容量约束，则将顾客添加到当前路径
    if load+demands(pre_point)<=cap
        load=load+demands(pre_point);       %初始在配送中心的装载量增加
        unvisited(unvisited==pre_point)=[]; %将pre_point从unvisit中删除
        visited=[visited,pre_point];        %把pre_point添加到visit中
        route=[route,pre_point];            %更新当前路线
    else   %一旦超过车辆装载量约束，则需要增加一辆车
        %先储存上一辆车所经过的顾客
        init_vc{k,1}=route;
        %然后将route清空，load清零,k加1
        route=[];
        load=0;
        k=k+1;
    end
    %如果遍历到unvisited中最后一个顾客，则更新init_vc，并跳出程序
    if isempty(unvisited)
        init_vc{k,1}=route;
        break
    end
end
end