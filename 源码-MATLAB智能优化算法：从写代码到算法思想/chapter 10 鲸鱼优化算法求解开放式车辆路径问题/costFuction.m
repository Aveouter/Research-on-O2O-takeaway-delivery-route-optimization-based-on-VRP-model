%% ���㵱ǰ���ͷ�����Ŀ�꺯��ֵ
%����VC��          ��ǰ���ͷ���
%����dist��        �������
%����demands��     �����˿�������
%����cap��         �������װ����
%����belta��       Υ��װ����Լ���ĳͷ�����ϵ��
%���cost��        ��ǰ���ͷ�����Ŀ�꺯��ֵ
function cost=costFuction(VC,dist,demands,cap,belta)
TD=travel_distance(VC,dist);            %���㵱ǰ���ͷ���������ʻ����
q=violateLoad(VC,demands,cap);          %�����������·���ϻ����뿪��������ʱΥ��������Լ��֮��
cost=TD+belta*q;                        %���㵱ǰ���ͷ�����Ŀ�꺯��ֵ
end