%% 对鲸鱼种群进行局部搜索操作
%输入population：      鲸鱼种群
%输入cusnum：          顾客数目
%输入cap：             货车最大装载量
%输入demands：         顾客需求量
%输入dist：            距离矩阵
%输入belta：           违反装载量约束的惩罚函数系数
%输出population：      局部搜索操作后得到的鲸鱼种群
function population=local_search(population,cusnum,cap,demands,dist,belta)
NIND=size(population,1);            %种群数目
N=size(population,2);               %鲸鱼个体长度
newPopulation=zeros(NIND,N);        %初始化局部搜索操作后的鲸鱼种群
%% 对原始鲸鱼种群的每个鲸鱼个体进行逆转操作
for i=1:NIND
    newPopulation(i,:)=reversion(population(i,:));
end
%% 计算目标函数值
obj1=obj_function(population,cusnum,cap,demands,dist,belta);          %计算原始鲸鱼种群的目标函数值
obj2=obj_function(newPopulation,cusnum,cap,demands,dist,belta);       %计算逆转操作后鲸鱼种群的目标函数值
%% 只有目标函数值变小，才会接受逆转操作后的鲸鱼个体
index1=obj2<obj1;
population(index1,:)=newPopulation(index1,:);
%% 对逆转操作后Population的每个鲸鱼个体进行插入操作
for i=1:NIND
    newPopulation(i,:)=insertion(population(i,:));
end
%% 计算目标函数值
obj1=obj_function(population,cusnum,cap,demands,dist,belta);          %计算原始鲸鱼种群的目标函数值
obj2=obj_function(newPopulation,cusnum,cap,demands,dist,belta);       %计算插入操作后鲸鱼种群的目标函数值
%% 只有目标函数值变小，才会接受插入操作后的鲸鱼个体
index2=obj2<obj1;
population(index2,:)=newPopulation(index2,:);
end