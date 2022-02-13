%% 局部搜索函数
%输入offspring：   被选择的若干个个体
%输入cusnum：      顾客数目
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入cap：         车辆最大装载量
%输入a：           顾客时间窗开始时间[a[i],b[i]]
%输入b：           顾客时间窗结束时间[a[i],b[i]]
%输入L：           配送中心时间窗结束时间
%输入s：           客户点的服务时间
%输入dist：        距离矩阵
%输入v：           车辆行驶速度
%输出offspring：   局部搜索后的若干个个体
function offspring=LocalSearch(offspring,v_num,cusnum,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v)
D=15;                                                                           %Remove过程中的随机元素
toRemove=min(ceil(cusnum/2),15);                                                %将要移出顾客的数量
[row,N]=size(offspring);
for i=1:row
    VC=decode(offspring(i,:),v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v); %将个体转换为配送方案               
    [removed,rfvc]=Remove(cusnum,toRemove,D,dist,VC);                           %破坏
    ReIfvc=Regret2Ins(removed,rfvc,demands,pdemands,cap,a,b,L,s,dist,v);        %修复
    CF=costFuction(VC,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v);         %计算修复前的个体目标函数值
    RCF=costFuction(ReIfvc,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v);    %计算修复后的个体目标函数值
    if RCF<CF
        Individual=change(ReIfvc,N,cusnum);
        offspring(i,:)=Individual;
    end
end