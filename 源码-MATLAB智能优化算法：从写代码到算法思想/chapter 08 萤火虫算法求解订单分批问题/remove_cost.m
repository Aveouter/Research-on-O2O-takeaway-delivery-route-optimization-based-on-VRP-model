%% ����ӵ�ǰ���������������Ƴ�һ�������ĳɱ�
%����order��               ���Ƴ��Ķ���
%����batches��             ��ǰ������������
%����orders��              ÿ����������������Ʒ��Ϣ
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���r_cost��              �ö������Ƴ��ɱ�
function r_cost=remove_cost(order,batches,orders,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle)
H=size(batches,1);                                              %����������Ŀ
%% ���ҵ�order������һ���ζ���
for i=1:H
    batch=batches{i};                                           %��i���ζ���
    findi=find(batch==order,1,'first');                         %�жϵ�ǰ���������Ƿ��б��Ƴ��Ķ���order
    if ~isempty(findi)
        at=i;                                                   %����order�����Ķ������α��
        break;
    end
end
%% �ټ��㶩��order���Ƴ��ɱ�
batch=batches{at,1};                                           %��at���ζ���
s_len1=shpath(batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
b_copy=batch;                                                  %����batch
b_copy(b_copy==order)=[];                                      %�������orderǡ���ڵ�ǰ���������У������Ƴ�
if ~isempty(b_copy)
    s_len2=shpath(b_copy,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
else
    s_len2=0;
end
r_cost=s_len1-s_len2;                                      %�����Ƴ�����ǰ���Ƴ�����������߾����ֵ
end