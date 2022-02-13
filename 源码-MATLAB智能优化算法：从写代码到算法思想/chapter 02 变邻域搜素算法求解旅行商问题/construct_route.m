%% 贪婪算法构造TSP的初始解
%输入dist：             距离矩阵   
%输出init_route：      贪婪算法构造的初始路线
%输出init_len：        init_route的总距离  
function [init_route,init_len]=construct_route(dist)
N=size(dist,1);                     %城市数目
%先将距离矩阵主对角线上的0赋值为无穷大
for i=1:N
    for j=1:N
        if i==j
            dist(i,j)=inf;
        end
    end
end

unvisited=1:N;                      %初始未被安排的城市集合
visited=[];                         %初始已被安排的城市集合

min_dist=min(min(dist));            %找出距离矩阵中的最小值
[row,col]=find(dist==min_dist);     %在dist中找出min_dist所对应的行和列
first=row(1);                       %将min_dist在dist中所对应行序号作为起点

unvisited(unvisited==first)=[];     %将first从unvisit中删除
visited=[visited,first];            %把first添加到visit中
pre_point=first;                    %将fisrt赋值给pre_point
while ~isempty(unvisited)
    pre_dist=dist(pre_point,:);     %pre_point与其它城市的距离
    pre_dist(visited)=inf;          %将pre_point与已经添加进来的城市之间的距离设位无穷大
    [~,pre_point]=min(pre_dist);    %找出pre_dist中的最小值
    unvisited(unvisited==pre_point)=[]; %将pre_point从unvisit中删除
    visited=[visited,pre_point];        %把pre_point添加到visit中
end
init_route=visited;
init_len=route_length(init_route,dist); %计算init_route的总距离
end