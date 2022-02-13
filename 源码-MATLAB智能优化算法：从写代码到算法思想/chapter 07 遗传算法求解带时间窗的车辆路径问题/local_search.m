%% 局部搜索操作
%输入SelCh：           变异操作后的子代种群
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
%输出SelCh：           局部搜索后的子代种群
function SelCh=local_search(SelCh,cusnum,cap,demands,a,b,L,s,dist,alpha,belta,v)
D=15;                               %破坏过程中的随机元素
toRemove=min(ceil(cusnum/2),15);    %将要移除的顾客数量
[row,N]=size(SelCh);                
for i=1:row
    %% 将第i个子代个体解码成配送方案
    VC=decode(SelCh(i,:),cusnum,cap,demands,a,b,L,s,dist,v);
    %% 计算解码出配送方案的总成本
    CF=cost_fuction(VC,a,b,s,L,dist,demands,cap,alpha,belta,v);
    %% 破坏操作
    [removed,rfvc]=remove(cusnum,toRemove,D,dist,VC);
    %% 修复操作
    ReIfvc=re_inserting(removed,rfvc,cap,demands,a,b,L,s,dist,v);
    %计算惩罚函数
    RCF=cost_fuction(ReIfvc,a,b,s,L,dist,demands,cap,alpha,belta,v);
    if RCF<CF
        chrom=change(ReIfvc,N,cusnum);
        SelCh(i,:)=chrom;
    end
end