%% �ж�һ�����������Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������
%����batch��                       ��ǰ��������
%����orders��                      ������������������Ʒ��Ϣ
%����item_weight��                 ÿ����λƷ�������
%����capacity��                    �豸���װ����
%���flagB��                       ��ǵ�ǰ���������Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������
function flagB=judge_batch(batch,orders,item_weight,capacity)
flagB=1;                                                    %��ʼ����װ����Լ��
batch_weight=cal_batch_weight(batch,orders,item_weight);    %����ĳһ���ζ�����װ����
%���������װ��������flagR��Ϊ0
if batch_weight>capacity
    flagB=0;
end
end