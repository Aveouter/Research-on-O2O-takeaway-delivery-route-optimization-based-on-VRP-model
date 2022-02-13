%% WorstRemove�������Ƴ��߳ɱ��Ķ���
%����toRemove��            �Ƴ���������Ŀ
%����D��                   ���Ԫ��
%����batches��             ��ǰ������������
%����orders��              ÿ����������������Ʒ��Ϣ
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���removed��             �Ƴ������ļ���
%���r_batches��           �Ƴ�removed�ж�����Ķ�����������
function [removed,r_batches]=worst_remove(toRemove,D,batches,orders,side_num,...
        depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
currB=batches;
removed=[];
while toRemove>0          
    [SRC,Sindex]=sort_cost(currB,orders,side_num,depot_leftAisle,...
        enter_leave_aisle,adjacent_location,adjacent_aisle);% ����ǰ���еĶ��������Ƴ��ɱ��Ӵ�С����
    ls=size(Sindex,1);                                  %��ǰ���ж�����Ŀ
    rvc=Sindex(ceil(rand^D*ls));                        %ѡ���Ƴ��Ķ���
    removed=[removed rvc];                              %�����Ƴ��Ķ�����ӵ�������
    currB=dealRemove(rvc,currB);                        %�������ӵ�ǰ�����Ƴ�
    toRemove=toRemove-1;                                %���±��Ƴ�������Ŀ
end
r_batches=currB;
end