%% �ز����Ӵ�������Ⱥ
%����Chrom��               ������Ⱥ
%����SelCh��               �Ӵ���Ⱥ
%����Obj��                 ������Ӧ��
%���Chrom��               �����õ�������Ⱥ
function Chrom=Reins(Chrom,SelCh,Obj)
NIND=size(Chrom,1);
NSel=size(SelCh,1);
[~,index]=sort(Obj,'descend');
Chrom=[Chrom(index(1:NIND-NSel),:);SelCh];