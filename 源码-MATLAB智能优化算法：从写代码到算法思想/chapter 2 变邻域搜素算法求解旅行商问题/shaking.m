%% �Ŷ������ѡ��ǰ�����е�һ������µ�ǰ��
%����route��           һ��·��
%����dist��            �������
%����k��               ��ǰ�������
%���route_shake��     �Ŷ�������õ���·��
%���len_shake��       ����·�ߵľ���
function [route_shake,len_shake]=shaking(route,dist,k)
N=numel(route);                                                     %������Ŀ
select_no=randi([1,N],1,2);                                         %���ѡ����в���������������
i=select_no(1);
j=select_no(2);
if k==1
    route_shake=swap(route,i,j);
elseif k==2
    route_shake=reversion(route,i,j);
else
    route_shake=insertion(route,i,j);
end
len_shake=route_length(route_shake,dist);
end