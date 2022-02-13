%% ѡ�����
%����Chrom��               ��Ⱥ
%����FitnV��               ��Ӧ��ֵ
%����GGAP��                ����
%���SelCh��               ��ѡ��ĸ���
function SelCh=Select(Chrom,FitnV,GGAP)
NIND=size(Chrom,1);                 %��Ⱥ��Ŀ
Nsel=NIND*GGAP;
total_FitnV=sum(FitnV);             %���и������Ӧ��֮��
select_p=FitnV./total_FitnV;        %����ÿ�����屻ѡ�еĸ���
select_index=zeros(Nsel,1);         %���汻ѡ�еĸ������
%��select_p�����ۼӲ�����c(i)=sum(select_p(1:i))
%���select_p=[0.1,0.2,0.3,0.4]����c=[0.1,0.3,0.6,1]
c=cumsum(select_p);
%% ѭ��NIND�Σ�ѡ��NIND������
for i=1:Nsel
    r=rand;                         %0~1֮��������
    index=find(r<=c,1,'first');     %ÿ�α�ѡ����ĸ������
    select_index(i,1)=index;
end
SelCh=Chrom(select_index,:);        %��ѡ�еĸ���