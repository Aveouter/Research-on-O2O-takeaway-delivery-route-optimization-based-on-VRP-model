%% ����Ⱥ��ѡ��Ŀ�꺯��ֵ��ǰ10%�ĸ���
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
%���offspring��           Ŀ�꺯��ֵ��ǰ10%��ө������
function offspring=select(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha)
NIND=size(Population,1);                    %��Ⱥ��Ŀ
Obj=obj_function(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
[~,index]=sort(Obj);                        %����Ⱥ����Ŀ�꺯��ֵ��С�����˳���������
off_num=ceil(NIND*0.1);                     %ѡ����ĺ��������Ŀ
offspring=Population(index(1:off_num),:);   %ѡ����ĺ������
end