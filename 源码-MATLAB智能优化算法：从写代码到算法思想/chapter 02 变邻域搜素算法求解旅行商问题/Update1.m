%% swap�����������µľ�������Delta
%����route��            һ��·��
%����dist��             �������
%����i��j��             ������i,j
%���Delta1��           swap������ľ����ֵ�ľ���
function Delta1=Update1(route,dist,i,j)
N=numel(route);                     %���и���
route2=swap(route,i,j);             %����route��i��j����λ���ϵĳ���
Delta1=zeros(N,N);                  %N��N�е�Delta��ʼ����ÿ��λ���ϵ�Ԫ���Ǿ����ֵ
for i=1:N-1
    for j=i+1:N
        Delta1(i,j)=cal_delta1(route2,dist,i,j);
    end
end