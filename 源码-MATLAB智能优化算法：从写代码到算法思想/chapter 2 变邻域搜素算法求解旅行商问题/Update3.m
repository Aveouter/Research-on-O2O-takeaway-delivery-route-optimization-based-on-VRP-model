%% insertion�����������µľ�������Delta
%����route��            һ��·��
%����dist��             �������
%����i��j��             �����i,j
%���Delta1��           insertion������ľ����ֵ�ľ���
function Delta3=Update3(route,dist,i,j)
N=numel(route);                     %���и���
route2=insertion(route,i,j);        %����route��i��j����λ���ϵĳ���
Delta3=zeros(N,N);                  %N��N�е�Delta��ʼ����ÿ��λ���ϵ�Ԫ���Ǿ����ֵ
for i=1:N
    for j=1:N
        if i~=j
            Delta3(i,j)=cal_delta3(route2,dist,i,j);
        end
    end
end