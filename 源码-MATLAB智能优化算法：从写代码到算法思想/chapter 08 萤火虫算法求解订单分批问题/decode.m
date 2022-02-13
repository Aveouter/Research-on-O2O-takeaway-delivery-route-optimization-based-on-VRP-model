%% ����ǰө���������Ϊ������������
%����firefly��             ��ǰө������
%����orders��              ÿ����������������Ʒ��Ϣ
%����batches_maxnum��      ��������������Ŀ
%����orders_num��          ������Ŀ
%����capacity��            �豸���װ����
%����item_weight��         ÿ����λ��Ʒ������
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���batches��             ������������
%���batches_num��         ����������Ŀ
%���TD��                  �����߾���
%���violate_batch��       Υ��Լ������������Ŀ
%���violate_order��       Υ��Լ��������Ŀ
function [batches,batches_num,TD,violate_batch,violate_order]=decode(firefly,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
violate_batch=0;                                %Υ��Լ������������Ŀ
violate_order=0;                                %Υ��Լ��������Ŀ
batches=cell(batches_maxnum,1);                 %��ʼ��������������
count=1;                                        %�������μ�����
split=find(firefly>orders_num);                 %�ҳ�ө�������ж������ηָ����ֵ�λ��
n=numel(split);                                 %�������ηָ����ֵ���Ŀ
for i=1:n
    if i==1                                     %��1���������ηָ����ֵ�λ��
        batch=firefly(1:split(i));              %��ȡ�����������ηָ�����֮��Ķ���
        batch(batch==firefly(split(i)))=[];     %ɾ�����������ж������ηָ�����
    else
        batch=firefly(split(i-1):split(i));     %��ȡ�����������ηָ�����֮��Ķ���
        batch(batch==firefly(split(i-1)))=[];   %ɾ�����������ж������ηָ�����
        batch(batch==firefly(split(i)))=[];     %ɾ�����������ж������ηָ�����
    end
    batches{count}=batch;                       %���¶�����������
    count=count+1;                              %���¶���������Ŀ
end
batch=firefly(split(end):end);                  %���һ������      
batch(batch==firefly(split(end)))=[];           %ɾ�����������ж������ηָ�����
batches{count}=batch;                           %���¶�����������
[batches,batches_num]=deal_batches(batches);    %��batches�пյ������Ƴ�
for j=1:batches_num
    batch=batches{j};
    %�е�j���������Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������
    flagR=judge_batch(batch,orders,item_weight,capacity);
    if flagR==0
        violate_order=violate_order+length(batch); %�����j������������Լ������Υ��Լ��������Ŀ�ӵ�j�������������Ķ�����Ŀ
        violate_batch=violate_batch+1;             %�����j������������Լ������Υ��Լ���Ķ���������Ŀ��1
    end
end
TD=travel_distance(batches,orders,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle);     %�÷��������߾���
end