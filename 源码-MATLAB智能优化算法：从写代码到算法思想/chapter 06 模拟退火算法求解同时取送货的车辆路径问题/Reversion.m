%% ��ת����
%���赱ǰ��Ϊ123456���������ѡ������λ�ã�Ȼ��������λ��֮���Ԫ�ؽ����������С�
%����˵����ת2��5֮�������Ԫ�أ�����ת��Ľ�Ϊ154326��
%����Scurr��       ��ǰ��
%���Snew��        ������ת������õ����½�
function Snew=Reversion(Scurr)
n=length(Scurr);
seq=randperm(n);
I=seq(1:2);
i1=min(I);
i2=max(I);
Snew=Scurr;
Snew(i1:i2)=Scurr(i2:-1:i1);
end