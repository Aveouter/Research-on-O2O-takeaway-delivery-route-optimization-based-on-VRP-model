%% ���㶩�����������ļ�ѡ�����߾��룬�Լ�ÿ���ζ����ļ�ѡ���߾���
%����batches��             ���ж����ķ������
%����orders��              ÿ����������������Ʒ��Ϣ
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���sumTD��               ��ѡ�����߾���
%���everyTD��             ��ѡÿ���ζ��������ߵľ���
function [sumTD,everyTD]=travel_distance(batches,orders,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle)
H=size(batches,1);                      %����������Ŀ
everyTD=zeros(H,1);
for i=1:H
    batch=batches{i,1};                 %��i���ζ���
    if ~isempty(batch)
        %ÿ���ζ����ļ�ѡ���߾���
        everyTD(i)=shpath(batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    end
end
sumTD=sum(everyTD);                     %�������������ļ�ѡ�����߾���
end