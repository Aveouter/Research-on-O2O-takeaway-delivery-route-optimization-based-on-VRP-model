%% ��route���Ͻ��н������������õ���·���Լ�����Ӧ���ܾ���
%����route��           һ��·��
%����dist��            �������
%����M��               ��������������Ĵ���
%���swap_route��      ��route���Ͻ��н������������õ���·��
%���swap_len��        swap_route���ܾ���
function [swap_route,swap_len]=swap_neighbor(route,dist,M)
N=numel(route);         %������Ŀ
Delta1=zeros(N,N);      %������������λ��֮�����е�Ԫ�������ľ����ľ���
for i=1:N-1
    for j=i+1:N
        Delta1(i,j)=cal_delta1(route,dist,i,j);
    end
end
cur_route=route;                                                    %��ʼ����ǰ·��
m=1;                                                                %��ʼ��������
while m<=M
    min_value=min(min(Delta1));                                     %�ҳ������ֵ��������С�ľ����ֵ
    %���min_valueС��0�����ܸ��µ�ǰ·�ߺ;�����󡣷�����ֹѭ��
    if min_value<0
        [min_row,min_col]=find(Delta1==min_value);                  %�ҳ������ֵ��������С�ľ����ֵ����Ӧ���к���
        Delta1=Update1(cur_route,dist,min_row(1),min_col(1));       %���¾����ֵ����
        cur_route=swap(cur_route,min_row(1),min_col(1));            %���µ�ǰ·��
    else
        break
    end
    m=m+1;
end
swap_route=cur_route;                                               %����ǰ·��cur_route��ֵ��swap_route
swap_len=route_length(swap_route,dist);                             %swap_route���ܾ���
end