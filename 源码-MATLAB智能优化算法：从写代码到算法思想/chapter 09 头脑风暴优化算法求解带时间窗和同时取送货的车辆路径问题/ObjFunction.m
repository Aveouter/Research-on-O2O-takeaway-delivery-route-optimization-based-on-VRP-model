%% 计算种群目标函数值，即每个个体解码出的配送方案的总成本
%输入Population：  种群
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
%输出Obj：         每个个体的目标函数值
function Obj=ObjFunction(Population,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta)
NIND=size(Population,1);                                                        %种群大小
Obj=zeros(NIND,1);                                                              %目标函数初始化为0
for i=1:NIND
    Individual=Population(i,:);                                                 %当前个体
    VC=decode(Individual,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v);     %将个体转换为配送方案
    Obj(i,1)=costFuction(VC,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v);   %计算当前个体的总成本
end
end