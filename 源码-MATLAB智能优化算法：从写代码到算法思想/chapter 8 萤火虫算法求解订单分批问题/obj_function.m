%% ������Ⱥ��ÿ��ө����Ŀ�꺯��ֵ
%����Population��          ��Ⱥ
%����orders��              ÿ����������������Ʒ��Ϣ
%����batches_maxnum��      ��������������Ŀ
%����orders_num��          ������Ŀ
%����capacity��            �豸���װ����
%����item_weight��         ÿ����λƷ�������
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%����alpha��               Υ���豸װ����Լ���ĳͷ�����
%���Obj��                 ��Ⱥ��ÿ��ө����Ŀ�꺯��ֵ
function Obj=obj_function(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha)
NIND=size(Population,1);                %ө�����Ŀ
Obj=size(NIND,1);                       %��ʼ��Ŀ�꺯��ֵ
for i=1:NIND
    Individual=Population(i,:);         %��i��ө���
    batches=decode(Individual,orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);           %����
    Obj(i,1)=cost_function(batches,orders,item_weight,capacity,side_num,depot_leftAisle,...
        enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);                              %Ϊ��i��ө���Ŀ�꺯��ֵ��ֵ  
end
end