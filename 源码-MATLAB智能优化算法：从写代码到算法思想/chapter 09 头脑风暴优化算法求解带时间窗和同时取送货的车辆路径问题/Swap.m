%% ��������
%����˵��6��Ԫ�أ���ǰ��Ϊ123456���������ѡ������λ�ã�Ȼ��������λ���ϵ�Ԫ�ؽ��н�����
%����˵������2��5����λ���ϵ�Ԫ�أ��򽻻���Ľ�Ϊ153426��
%����Individual1��    ����1
%���Individual2��    ��������������ĸ���2
function Individual2=Swap(Individual1)
n=length(Individual1);          %���峤��
seq=randperm(n);
I=seq(1:2);
i1=I(1);
i2=I(2);
Individual2=Individual1;
Individual2([i1 i2])=Individual1([i2 i1]);
end