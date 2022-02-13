%% ����·��R����Ϣ��
%����Tau��                 ����ǰ����Ϣ�ؾ���
%����bestR��               ��������������������·��
%����rho��                 ��Ϣ�ػӷ�����
%����Q��                   ���Ϲ���һ������·�����ͷŵ���Ϣ������
%����cap��                 ���װ����
%����demands��             ������
%����dist��                �������
%���Tau��                 ���º����Ϣ�ؾ���
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