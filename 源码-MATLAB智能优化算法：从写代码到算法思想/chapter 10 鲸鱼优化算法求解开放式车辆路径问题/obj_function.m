%% 计算种群的目标函数值
%输入population：  鲸鱼种群
%输入cusnum：      顾客数目
%输入cap：         货车最大装载量
%输入demands：     顾客需求量
%输入dist：        距离矩阵
%输入belta：       违反装载量约束的惩罚函数系数
%输出obj：         鲸鱼种群的目标函数值
function obj=obj_function(population,cusnum,cap,demands,dist,belta)
NIND=size(population,1);                   %种群数目
obj=zeros(NIND,1);                         %储存每个个体函数值
for i=1:NIND
    VC=decode(population(i,:),cusnum,cap,demands,dist);     %将鲸鱼个体解码为配送方案
    costF=costFuction(VC,dist,demands,cap,belta);           %计算当前配送方案的目标函数值
    obj(i)=costF;                                           %将当前配送方案的目标函数值赋值给第i个鲸鱼个体目标函数值
end
end