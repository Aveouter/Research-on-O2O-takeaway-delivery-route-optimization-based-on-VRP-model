%% ���㵱ǰ�������������ж�������Ŀ
%����batches��         ������������
%���order_num��       ��ǰ�������������ж�����Ŀ
function order_num=curr_num(batches)
H=size(batches,1);          %�������������ж���������Ŀ
order_num=0;                %��ʼ������ĿΪ0
for i=1:H
    batch=batches{i};       %��i���ζ���
    n=numel(batch);         %��i���ζ����������Ķ�����Ŀ
    order_num=order_num+n;  %�ۼ�
end
end