%% ����һ�����������������ܳɱ��������ڸö��������������߾���+alpha*Υ���豸װ����Լ���ɱ�֮��
%����batches��             ������������
%����orders��              ÿ����������������Ʒ��Ϣ
%����item_weight��         ÿ����λƷ�������
%����capacity��            �豸���װ����
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%����alpha��               Υ������豸װ����Լ���ĳͷ�����
%���cost��                ���������������ܳɱ�
function cost=cost_function(batches,orders,item_weight,capacity,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle,alpha)
H=size(batches,1);                 %����������Ŀ
%% ���㶩�����������������߾���cost1
cost1=travel_distance(batches,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
%% Υ���豸װ����Լ���ɱ�֮��cost2
cost2=0;                            %��ʼΥ���豸װ����Լ��֮��
for i=1:H
    batch=batches{i,1};             %��i���ζ���
    batch_weight=cal_batch_weight(batch,orders,item_weight);    %��i���ζ���װ����
    %�����i���ζ���װ���������豸װ���������cost1�����ۼ�
    if batch_weight>capacity
        cost2=cost2+batch_weight-capacity;
    end
end
%% �ܳɱ�=cost1+alpha*cost2
cost=cost1+alpha*cost2;
end