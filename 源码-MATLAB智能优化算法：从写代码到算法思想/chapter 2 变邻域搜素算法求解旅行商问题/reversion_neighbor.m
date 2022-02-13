%% 对route不断进行逆转操作后所得到的路线以及所对应的总距离
%输入route：           一条路线
%输入dist：            距离矩阵
%输入M：               最多进行M次邻域操作
%输出reversion_route： 对route不断进行逆转操作后所得到的路线
%输出reversion_len：   reversion_route的总距离
function [reversion_route,reversion_len]=reversion_neighbor(route,dist,M)
N=numel(route);         %城市数目
Delta2=zeros(N,N);      %逆转任意两个位置之间序列的元素所产的距离差的矩阵
for i=1:N-1
    for j=i+1:N
        Delta2(i,j)=cal_delta2(route,dist,i,j);
    end
end
cur_route=route;                                                    %初始化当前路线
m=1;                                                                %初始化计数器
while m<=M
    min_value=min(min(Delta2));                                     %找出距离差值矩阵中最小的距离差值
    %如果min_value小于0，才能更新当前路线和距离矩阵。否则，终止循环
    if min_value<0
        [min_row,min_col]=find(Delta2==min_value);                  %找出距离差值矩阵中最小的距离差值所对应的行和列
        Delta2=Update2(cur_route,dist,min_row(1),min_col(1));       %更新距离差值矩阵
        cur_route=reversion(cur_route,min_row(1),min_col(1));       %更新当前路线
    else
        break
    end
    m=m+1;
end
reversion_route=cur_route;                                          %将当前路线cur_route赋值给reversion_route
reversion_len=route_length(reversion_route,dist);                   %reversion_route的总距离
end