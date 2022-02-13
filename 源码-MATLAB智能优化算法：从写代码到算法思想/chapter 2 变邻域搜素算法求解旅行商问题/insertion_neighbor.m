%% ��route���Ͻ��в�����������õ���·���Լ�����Ӧ���ܾ���
%����route��           һ��·��
%����dist��            �������
%����M��               ������M���������
%���insertion_route�� ��route���Ͻ��в�����������õ���·��
%���insertion_len��   insertion_route���ܾ���
function [insertion_route,insertion_len]=insertion_neighbor(route,dist,M)
N=numel(route);         %������Ŀ
Delta3=zeros(N,N);      %������������λ��֮�����е�Ԫ�������ľ����ľ���
for i=1:N-1
    for j=i+1:N
        Delta3(i,j)=cal_delta3(route,dist,i,j);
    end
end
cur_route=route;                                                    %��ʼ����ǰ·��
m=1;                                                                %��ʼ��������
while m<=M
    min_value=min(min(Delta3));                                     %�ҳ������ֵ��������С�ľ����ֵ
    %���min_valueС��0�����ܸ��µ�ǰ·�ߺ;�����󡣷�����ֹѭ��
    if min_value<0
        [min_row,min_col]=find(Delta3==min_value);                  %�ҳ������ֵ��������С�ľ����ֵ����Ӧ���к���
        Delta3=Update3(cur_route,dist,min_row(1),min_col(1));       %���¾����ֵ����
        cur_route=insertion(cur_route,min_row(1),min_col(1));       %���µ�ǰ·��
    else
        break
    end
    m=m+1;
end
insertion_route=cur_route;                                          %����ǰ·��cur_route��ֵ��insertion_route
insertion_len=route_length(insertion_route,dist);                   %insertion_route���ܾ���
end