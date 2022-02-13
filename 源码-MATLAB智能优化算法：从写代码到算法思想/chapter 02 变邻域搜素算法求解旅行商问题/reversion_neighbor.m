%% ��route���Ͻ�����ת���������õ���·���Լ�����Ӧ���ܾ���
%����route��           һ��·��
%����dist��            �������
%����M��               ������M���������
%���reversion_route�� ��route���Ͻ�����ת���������õ���·��
%���reversion_len��   reversion_route���ܾ���
function [reversion_route,reversion_len]=reversion_neighbor(route,dist,M)
N=numel(route);         %������Ŀ
Delta2=zeros(N,N);      %��ת��������λ��֮�����е�Ԫ�������ľ����ľ���
for i=1:N-1
    for j=i+1:N
        Delta2(i,j)=cal_delta2(route,dist,i,j);
    end
end
cur_route=route;                                                    %��ʼ����ǰ·��
m=1;                                                                %��ʼ��������
while m<=M
    min_value=min(min(Delta2));                                     %�ҳ������ֵ��������С�ľ����ֵ
    %���min_valueС��0�����ܸ��µ�ǰ·�ߺ;�����󡣷�����ֹѭ��
    if min_value<0
        [min_row,min_col]=find(Delta2==min_value);                  %�ҳ������ֵ��������С�ľ����ֵ����Ӧ���к���
        Delta2=Update2(cur_route,dist,min_row(1),min_col(1));       %���¾����ֵ����
        cur_route=reversion(cur_route,min_row(1),min_col(1));       %���µ�ǰ·��
    else
        break
    end
    m=m+1;
end
reversion_route=cur_route;                                          %����ǰ·��cur_route��ֵ��reversion_route
reversion_len=route_length(reversion_route,dist);                   %reversion_route���ܾ���
end