%% �ֲ���������
%����offspring��           ��ѡ���ө������          
%����orders��              ÿ����������������Ʒ��Ϣ
%����batches_maxnum��      ��������������Ŀ
%����orders_num��          ������Ŀ
%����capacity��            �豸���װ����
%����item_weight��         ÿ����λƷ�������
%����alpha��               Υ���豸װ����Լ���ĳͷ�����
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%����alpha��               Υ���豸װ����Լ���ĳͷ�����
%���offspring��           �ֲ��������ө������
function offspring=local_search(offspring,orders,batches_maxnum,orders_num,capacity,item_weight,alpha,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
D=15;                                                %Remove�����е����Ԫ��
toRemove=min(ceil(orders_num/2),15);                 %��Ҫ�Ƴ�������Ŀ
N=size(offspring,2);                                 %ө�����峤��
Obj1=obj_function(offspring,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha); %����ֲ�����ǰoffspring��Ŀ�꺯��ֵObj1
off_num=size(offspring,1);              %offspring��ө������Ŀ
for i=1:off_num
    %% ����
    batches=decode(offspring(i,:),orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %% �Ƴ�����
    [removed,r_batches]=worst_remove(toRemove,D,batches,orders,side_num,...
        depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %% �������
    ReBatches=greedy_ins(removed,r_batches,orders,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %% �����޸���Ķ������������ܳɱ�
    RCF=cost_function(ReBatches,orders,item_weight,capacity,side_num,depot_leftAisle,...
        enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
    %% ֻ���޸���Ķ��������������ţ����ܽ����޸���Ķ�����������
    if RCF<Obj1(i,1)
        offspring(i,:)=change(ReBatches,N,orders_num);
    end
end
end