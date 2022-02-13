%% 对route不断进行插入操作后所得到的路线以及所对应的总距离
%输入route：           一条路线
%输入dist：            距离矩阵
%输入M：               最多进行M次邻域操作
%输出insertion_route： 对route不断进行插入操作后所得到的路线
%输出insertion_len：   insertion_route的总距离
function [insertion_route,insertion_len]=insertion_neighbor(route,dist,M)
N=numel(route);         %城市数目
Delta3=zeros(N,N);      %插入任意两个位置之间序列的元素所产的距离差的矩阵
for i=1:N-1
    for j=i+1:N
        Delta3(i,j)=cal_delta3(route,dist,i,j);
    end
end
cur_route=route;                                                    %初始化当前路线
m=1;                                                                %初始化计数器
while m<=M
    min_value=min(min(Delta3));                                     %找出距离差值矩阵中最小的距离差值
    %如果min_value小于0，才能更新当前路线和距离矩阵。否则，终止循环
    if min_value<0
        [min_row,min_col]=find(Delta3==min_value);                  %找出距离差值矩阵中最小的距离差值所对应的行和列
        Delta3=Update3(cur_route,dist,min_row(1),min_col(1));       %更新距离差值矩阵
        cur_route=insertion(cur_route,min_row(1),min_col(1));       %更新当前路线
    else
        break
    end
    m=m+1;
end
insertion_route=cur_route;                                          %将当前路线cur_route赋值给insertion_route
insertion_len=route_length(insertion_route,dist);                   %insertion_route的总距离
end