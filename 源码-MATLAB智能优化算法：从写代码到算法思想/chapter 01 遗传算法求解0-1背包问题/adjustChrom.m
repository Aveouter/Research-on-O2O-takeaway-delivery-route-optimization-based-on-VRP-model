%% ������ȺȾɫ�壬��������������Լ����Ⱦɫ����е���
%����Chrom��               ��Ⱥ
%����w��                   ������Ʒ������
%����p��                   ������Ʒ�ļ�ֵ
%����cap��                 ����������
%���Chrom��               �������Ⱦɫ�壬ȫ������������Լ��
function Chrom=adjustChrom(Chrom,w,p,cap)
NIND=size(Chrom,1);                                             %NIND��Ⱥ��С
for i=1:NIND
    Individual=Chrom(i,:);                                      %��i������
    flag=judge_individual(Individual,w,cap);                    %�ж�random_Individual�Ƿ����㱳����������Լ����1��ʾ���㣬0��ʾ������
    %% ���flagΪ0������Ҫ�޸�����Individual�����򣬲���Ҫ�޸�
    if flag==0
        Individual=repair_individual(Individual,w,p,cap);       %�޸�����Individual
        Chrom(i,:)=Individual;                                  %���µ�i������
    end
end
end