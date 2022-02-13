%% ����ǰ�������������еĶ��������Ƴ��ɱ��Ӵ�С����
%����batches��             ��ǰ������������
%����orders��              ÿ����������������Ʒ��Ϣ
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ������ͨ�������ѡͨ����Ӽ�ѡͨ����������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���SRC��                 �Ƴ��ɱ��������н��
%���Sindex��              SRC����Ӧ�Ķ������
function [SRC,Sindex]=sort_cost(batches,orders,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle)
sNum=curr_num(batches);                                   %��ǰ���й˿͵���Ŀ
SRC=zeros(sNum,1);                                  %�洢�Ƴ��ɱ��Ӵ�С����
Sindex=zeros(sNum,1);                               %�洢�Ƴ��ɱ��Ӵ�С��������
NV=size(batches,1);                                      %������Ŀ
count=1;
for i=1:NV
    batch=batches{i};
    b_copy=batch;
    lr=numel(b_copy);
    for j=1:lr
        r_cost=remove_cost(b_copy(j),batches,orders,side_num,depot_leftAisle,...
            enter_leave_aisle,adjacent_location,adjacent_aisle);   %�洢�Ƴ��ĳɱ�
        SRC(count,1)=r_cost;
        Sindex(count)=b_copy(j);                    %�洢�Ƴ��Ĺ˿����
        count=count+1;                              %��������1
    end
end
[SRC,id]=sort(SRC,'descend');                       %���Ƴ��ɱ����齵������
Sindex=Sindex(id);                                  %���������������Ӧ�˿����
end