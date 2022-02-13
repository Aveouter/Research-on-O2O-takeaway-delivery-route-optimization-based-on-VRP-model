%% 更新路径R的信息素
%输入Tau：                 更新前的信息素矩阵
%输入bestR：               最优蚂蚁所构建的完整路径
%输入rho：                 信息素挥发因子
%输入Q：                   蚂蚁构建一次完整路径所释放的信息素总量
%输入cap：                 最大装载量
%输入demands：             需求量
%输入dist：                距离矩阵
%输出Tau：                 更新后的信息素矩阵
function Tau=updateTau(Tau,bestR,rho,Q,cap,demands,dist)
[~,~,bestTD]=decode(bestR,cap,demands,dist);
cusnum=size(dist,1)-1;
Delta_Tau=zeros(cusnum+1,cusnum+1);
delta_Tau=Q/bestTD;
for j=1:cusnum-1
    Delta_Tau(bestR(j),bestR(j+1))=Delta_Tau(bestR(j),bestR(j+1))+delta_Tau;
    Tau(bestR(j),bestR(j+1))=rho*Tau(bestR(j),bestR(j+1))+Delta_Tau(bestR(j),bestR(j+1));
end
Delta_Tau(bestR(cusnum),1)=Delta_Tau(bestR(cusnum),1)+delta_Tau;
Tau(bestR(cusnum),1)=rho*Tau(bestR(cusnum),1)+Delta_Tau(bestR(cusnum),1);
end