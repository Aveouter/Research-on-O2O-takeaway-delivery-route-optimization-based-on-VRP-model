%% ���㵱ǰ��ĳɱ�����
%����VC��          ���ͷ�������ÿ�����������Ĺ˿�
%����dist��        �������
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����cap��         �������װ����
%����belta��       Υ����װ����Լ���ĳͷ�ϵ��
%���cost��        ��ǰ���ͷ������ܳɱ� f=TD+belta*q
function cost=costFuction(VC,dist,demands,pdemands,cap,belta)
TD=travel_distance(VC,dist);
q=violateLoad(VC,demands,pdemands,cap);
cost=TD+belta*q;
end