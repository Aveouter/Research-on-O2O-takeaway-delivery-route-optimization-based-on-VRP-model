%% 将更新操作后得到的种群与局部搜索操作后得到的种群进行合并
%输入Population：      更新操作后得到的种群
%输入offspring：       局部搜索操作后得到的种群
%输入Obj：             更新操作后得到的种群的目标函数值
%输出Population：      合并两个种群后得到的新种群
function Population=merge(Population,offspring,Obj)
NIND=size(Population,1);
NSel=size(offspring,1);
[~,index]=sort(Obj);
Population=[Population(index(1:NIND-NSel),:);offspring];
end