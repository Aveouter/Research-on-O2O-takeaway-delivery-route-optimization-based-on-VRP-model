%% ��ת����
%��6���˿ͣ���ǰ�������Ϊ123456���������ѡ������λ�ã�Ȼ��������λ��֮���Ԫ�ؽ����������С�
%����˵����ת2��5֮�������Ԫ�أ�����ת��ľ������Ϊ154326��
%����individual��            ��ǰ�������
%���new_individual��        ������ת������õ����µľ������
function new_individual=reversion(individual)
n=length(individual);
seq=randperm(n);
I=seq(1:2);
i1=min(I);
i2=max(I);
new_individual=individual;
new_individual(i1:i2)=individual(i2:-1:i1);
end