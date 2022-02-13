%% 随机替换聚类中心
%输入p_replace：   用随机解替换一个聚类中心的概率
%输入cluster_num： 聚类数目
%输入N：           个体长度
%输入order_cluster：初始所储存的每个聚类
%输入v_num：       车辆最大允许使用数目
%输入cusnum：      顾客数目
%输入cap：         车辆最大装载量
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入a,b：         顾客时间窗结束时间[a[i],b[i]]
%输入s：           对每个顾客的服务时间
%输入L：           仓库时间窗结束时间
%输入dist：        距离矩阵
%输入v：           车辆行驶速度
%输入alpha：       违反的装载量约束的惩罚函数系数
%输入belta：       违反时间窗约束的惩罚函数系数
%输出order_cluster：将每个聚类中的个体按照目标函数值排序后的元胞数组
function order_cluster=replace_center(p_replace,cluster_num,N,order_cluster,...
    v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta)
%% 以一定的概率随机从m个聚类中心中选择出一个聚类中心，并用一个新产生的随机解更新这个被选中的聚类中心
R1=rand(1,1);
if R1<=p_replace
    %随机选择一个聚类中心
    repalce_cluster_num=randi([1,cluster_num],1,1);
    %随机产生一个解
    replace_solution=randperm(N);
    %并用这个新产生的随机解更新这个被选中的聚类中心
    order_cluster{repalce_cluster_num,1}(1,:)=replace_solution;
    %计算新解的目标函数值
    replace_solution_fitness=ObjFunction(replace_solution,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %将新解的目标函数值储存到order_cluster中
    order_cluster{repalce_cluster_num,2}(1,:)=replace_solution_fitness;
end
end