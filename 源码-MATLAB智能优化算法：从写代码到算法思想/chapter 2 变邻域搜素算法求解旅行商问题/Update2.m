%% reversion�����������µľ�������Delta
%����route��            һ��·��
%����dist��             �������
%����i��j��             ��ת��i,j
%���Delta2��           reversion������ľ����ֵ�ľ���
function Delta2=Update2(route,dist,i,j)
N=numel(route);                     %���и���
route2=reversion(route,i,j);        %��תroute��i��j����λ���ϵĳ���
Delta2=zeros(N,N);                  %N��N�е�Delta��ʼ����ÿ��λ���ϵ�Ԫ���Ǿ����ֵ
for i=1:N-1
    for j=i+1:N
        Delta2(i,j)=cal_delta2(route2,dist,i,j);
    end
end