%% �ж��ܷ�һ���������뵽һ���ζ����У�����ܣ��򽫸ö������뵽��Ѷ�������
%����order��               ����صĶ���
%����orders��              ÿ����������������Ʒ��Ϣ
%����batch��               ��ǰ���ζ���
%����capacity��            �豸���װ����
%����item_weight��         ÿ����λƷ�������
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���new_batch��           �������ɹ�����Ϊ�¶����������������ʧ�ܣ���Ϊԭ��������
%���flag��                ����Ƿ���˳����أ�flag=1��ʾ�ܲ��룬flag=0��ʾ���ܲ���
%���deltaC��              ��order��ص�batch�е���Ѳ�ز���ɱ�
function [new_batch,flag,deltaC]=ins_batch(order,orders,batch,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
r_batch=[order batch];                                        %��order��ӵ�batch��λ
flagR=judge_batch(r_batch,orders,item_weight,capacity);       %�ж�һ�����������Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������
if flagR==1
    %���㽫order��ص�batch��������߾���
    s_len1=shpath(r_batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %���㽫order��ص�batchǰ�������߾���
    s_len2=shpath(batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    flag=1;
    new_batch=r_batch;
    deltaC=s_len1-s_len2;                               %����orde�Ĳ���ɱ�
else
    %������ܽ�order���batch����flag��ֵΪ0����new_batch��ֵΪbatch��deltaC��ֵΪ�����
    flag=0;
    new_batch=batch;
    deltaC=inf;
end
end