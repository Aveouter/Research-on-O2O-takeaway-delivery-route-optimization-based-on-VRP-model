%% ��ʼ����Ⱥ
%����NIND��                ��Ⱥ��С
%����n��                   ��Ʒ��Ŀ
%����w��                   ������Ʒ������
%����p��                   ������Ʒ�ļ�ֵ
%����cap��                 ������������
%���Chrom��               ��ʼ��Ⱥ
function Chrom=InitPop(NIND,N,w,p,cap)
Chrom=zeros(NIND,N);                    %���ڴ洢��Ⱥ
for i=1:NIND
    Chrom(i,:)=encode(N,w,p,cap);       %���룬��������Լ���ĸ���
end