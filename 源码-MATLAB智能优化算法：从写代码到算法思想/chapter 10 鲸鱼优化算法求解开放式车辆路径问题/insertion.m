%% �������
%���赱ǰ�������Ϊ123456���������ѡ������λ�ã�Ȼ�����һ��λ���ϵ�Ԫ�ز��뵽�ڶ���Ԫ�غ��档
%����˵����һ��ѡ��5���λ�ã��ڶ���ѡ��2���λ�ã�������ľ������Ϊ125346��
%����individual��            ��ǰ�������
%���new_individual��        �������������õ����µľ������
function new_individual=insertion(individual)
n=length(individual);
seq=randperm(n);
I=seq(1:2);
i1=I(1);
i2=I(2);
if i1<i2
    new_individual=individual([1:i1-1 i1+1:i2 i1 i2+1:end]);
else
    new_individual=individual([1:i2 i1 i2+1:i1-1 i1+1:end]);
end
end