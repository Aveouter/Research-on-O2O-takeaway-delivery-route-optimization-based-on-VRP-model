%% ��removed�ж������ռ�ѡ���߾����ɴ�С����
%����removed��             ���Ƴ��Ķ�������
%����orders��              ÿ����������������Ʒ��Ϣ
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���sRemoved��            ��removed�����Ľ��
function sRemoved=removed_down_sort(removed,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
lr=numel(removed);              %���Ƴ���������Ŀ
len=zeros(lr,1);                %�洢removed�и������ļ�ѡ���߾���
for i=1:lr
    order=removed(i);           %��i�����Ƴ��Ķ���
    %��¼order�ļ�ѡ���߾���
    len(i)=shpath(order,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
end
[~,sindex]=sort(len,'descend'); %��len��������
sRemoved=removed(sindex);
end