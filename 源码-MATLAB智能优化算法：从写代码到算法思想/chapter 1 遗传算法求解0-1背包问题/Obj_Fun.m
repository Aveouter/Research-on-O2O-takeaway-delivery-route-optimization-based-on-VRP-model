%% ������Ⱥ��ÿ��Ⱦɫ�����Ʒ�ܼ�ֵ
%����Chrom��               ��Ⱥ
%����p��                   ������Ʒ�ļ�ֵ
%����w��                   ������Ʒ������
%���Obj��                 ��Ⱥ��ÿ���������Ʒ�ܼ�ֵ
function Obj=Obj_Fun(Chrom,p,w)
NIND=size(Chrom,1);        %��Ⱥ��С
n=size(Chrom,2);           %��Ʒ��Ŀ
Obj=zeros(NIND,1);
for i=1:NIND
    Obj(i,1)=Individual_P_W(n,Chrom(i,:),p,w);
end
end