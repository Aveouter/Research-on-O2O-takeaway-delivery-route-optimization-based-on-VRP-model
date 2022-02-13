%% 计算种群的目标函数值
%输入Chrom：           种群
%输入cusnum：          顾客数目
%输入cap：             车辆最大装载量
%输入demands：         顾客需求量
%输入a：               顾客左时间窗
%输入b：               顾客右时间窗
%输入L：               配送中心右时间窗
%输入s：               客户点的服务时间
%输入dist：            距离矩阵
%输入alpha：           违反的容量约束的惩罚函数系数
%输入belta：           违反时间窗约束的惩罚函数系数
%输入v：               车辆行驶速度
%输出Obj：             每个个体的目标函数值，即该个体解码后配送方案的总成本
function Obj=cal_obj(Chrom,cusnum,cap,demands,a,b,L,s,dist,alpha,belta,v)
NIND=size(Chrom,1);                         %种群数目
Obj=zeros(NIND,1);                          %储存每个个体的目标函数值
for i=1:NIND
    %将第i个个体解码成配送方案
    VC=decode(Chrom(i,:),cusnum,cap,demands,a,b,L,s,dist,v);
    %计算解码出的配送方案的总成本
    costF=cost_fuction(VC,a,b,s,L,dist,demands,cap,alpha,belta,v);
    Obj(i)=costF;
end
end