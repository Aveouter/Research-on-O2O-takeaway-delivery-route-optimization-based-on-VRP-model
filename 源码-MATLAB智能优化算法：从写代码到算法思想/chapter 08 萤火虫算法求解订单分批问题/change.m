%% ��������������ө������֮�����ת��
%����batches��             ������������
%����N��                   ө�����峤��
%����orders_num��          �ܶ�����Ŀ
%���firefly��             �ɶ�����������ת�����ɵ�ө������
function firefly=change(batches,N,orders_num)
H=size(batches,1);              	%�������������еĶ���������Ŀ
firefly=[];                     	%��ʼө������Ϊ��
for i=1:H
    if (orders_num+i)<=N
        firefly=[firefly,batches{i},orders_num+i];
    else
        firefly=[firefly,batches{i}];
    end
end
if length(firefly)<N                %���ө�����峤��С��N������Ҫ�������Ӷ������ηָ�����
    addition=(orders_num+H+1):N;
    firefly=[firefly,addition];
end
end