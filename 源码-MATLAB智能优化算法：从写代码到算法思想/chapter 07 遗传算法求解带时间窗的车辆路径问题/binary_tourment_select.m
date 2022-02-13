%% 二元锦标赛选择
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
%输出Selch：           二元锦标赛选择出的子代种群
function Selch=binary_tourment_select(Chrom,cusnum,cap,demands,a,b,L,s,dist,alpha,belta,v)
Obj=cal_obj(Chrom,cusnum,cap,demands,a,b,L,s,dist,alpha,belta,v);   %计算种群目标函数值，即每个个体的总成本        
fit=fitness(Obj);                       %计算每个个体的适应度值
NIND=size(Chrom,1);                     %种群数目
index=[];                               %储存被选中的个体编号
for i=1:NIND
    R=randperm(NIND);                   %生成一个1~NIND的随机排列
    index1=R(1);                        %第一个比较的个体序号
    index2=R(2);                        %第二个比较的个体序号
    fit1=fit(index1,:);                 %第一个比较的个体的适应度值（适应度值越大，说明个体质量越高）
    fit2=fit(index2,:);                 %第二个比较的个体的适应度值
    %如果个体1的适应度值 大于等于 个体2的适应度值，则将个体1作为第i选择出的个体
    if fit1>=fit2
        index=[index;index1];
    else
        %如果个体1的适应度值 小于 个体2的适应度值，则将个体2作为第i选择出的个体
        index=[index;index2];
    end
end
index=unique(index);
Selch=Chrom(index,:);
end