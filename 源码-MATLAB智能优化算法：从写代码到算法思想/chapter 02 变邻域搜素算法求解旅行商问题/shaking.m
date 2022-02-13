%% 扰动，随机选择当前邻域中的一个解更新当前解
%输入route：           一条路线
%输入dist：            距离矩阵
%输入k：               当前邻域序号
%输出route_shake：     扰动操作后得到的路线
%输出len_shake：       该条路线的距离
function [route_shake,len_shake]=shaking(route,dist,k)
N=numel(route);                                                     %城市数目
select_no=randi([1,N],1,2);                                         %随机选择进行操作的两个点的序号
i=select_no(1);
j=select_no(2);
if k==1
    route_shake=swap(route,i,j);
elseif k==2
    route_shake=reversion(route,i,j);
else
    route_shake=insertion(route,i,j);
end
len_shake=route_length(route_shake,dist);
end