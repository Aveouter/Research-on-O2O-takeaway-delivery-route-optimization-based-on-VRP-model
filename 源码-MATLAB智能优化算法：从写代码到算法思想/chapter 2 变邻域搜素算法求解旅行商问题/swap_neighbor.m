%% 对route不断进行交换操作后所得到的路线以及所对应的总距离
%输入route：           一条路线
%输入dist：            距离矩阵
%输入M：               最多进行邻域操作的次数
%输出swap_route：      对route不断进行交换操作后所得到的路线
%输出swap_len：        swap_route的总距离
function [swap_route,swap_len]=swap_neighbor(route,dist,M)
N=numel(route);         %城市数目
Delta1=zeros(N,N);      %交换任意两个位置之间序列的元素所产的距离差的矩阵
for i=1:N-1
    for j=i+1:N
        Delta1(i,j)=cal_delta1(route,dist,i,j);
    end
end
cur_route=route;                                                    %初始化当前路线
m=1;                                                                %初始化计数器
while m<=M
    min_value=min(min(Delta1));                                     %找出距离差值矩阵中最小的距离差值
    %如果min_value小于0，才能更新当前路线和距离矩阵。否则，终止循环
    if min_value<0
        [min_row,min_col]=find(Delta1==min_value);                  %找出距离差值矩阵中最小的距离差值所对应的行和列
        Delta1=Update1(cur_route,dist,min_row(1),min_col(1));       %更新距离差值矩阵
        cur_route=swap(cur_route,min_row(1),min_col(1));            %更新当前路线
    else
        break
    end
    m=m+1;
end
swap_route=cur_route;                                               %将当前路线cur_route赋值给swap_route
swap_len=route_length(swap_route,dist);                             %swap_route的总距离
end