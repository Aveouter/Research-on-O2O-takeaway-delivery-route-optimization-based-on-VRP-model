tic
clear
clc
%% ��������
%������Ʒ����������λkg
w=[80,82,85,70,72,70,82,75,78,45,49,76,45,35,94,49,76,79,84,74,76,63,...
    35,26,52,12,56,78,16,52, 16,42,18,46,39,80,41,41,16,35,70,72,70,66,50,55,25, 50,55,40];
%������Ʒ�ļ�ֵ����λԪ
p=[200,208,198,192,180,180,168,176,182,168,187,138,184,154,168,175,198,...
    184,158,148,174,135, 126,156,123,145,164,145,134,164,134,174,102,149,134,...
    156,172,164,101,154,192,180,180,165,162,160,158,155, 130,125];    
cap=1000;                                       %ÿ��������������Ϊ1000kg
n=numel(p);                                     %��Ʒ����
%% ��������
NIND=500;                                       %��Ⱥ��С
MAXGEN=500;                                     %��������
Pc=0.9;                                         %�������
Pm=0.08;                                        %�������
GGAP=0.9;                                       %����
%% ��ʼ����Ⱥ
Chrom=InitPop(NIND,n,w,p,cap);
%% �Ż�
gen=1;
bestIndividual=Chrom(1,:);                      %��ʼ����ʼ��Ⱥ��һ�����帳ֵ��ȫ�����Ÿ���
bestObj=Individual_P_W(n,bestIndividual,p,w);   %�����ʼbestIndividual����Ʒ�ܼ�ֵ
BestObj=zeros(MAXGEN,1);                        %��¼ÿ�ε��������е�������Ӧ��ֵ
while gen<=MAXGEN
    %% ������Ӧ��
    Obj=Obj_Fun(Chrom,p,w);                     %����ÿ��Ⱦɫ�����Ʒ�ܼ�ֵ
    FitnV=Obj;                                  %��Ӧ��ֵ=Ŀ�꺯��ֵ=��Ʒ�ܼ�ֵ
    %% ѡ��
    SelCh=Select(Chrom,FitnV,GGAP);
    %% �������
    SelCh=Crossover(SelCh,Pc);
    %% ����
    SelCh=Mutate(SelCh,Pm);
    %% �ز����Ӵ�������Ⱥ
    Chrom=Reins(Chrom,SelCh,Obj);
    %% ����Ⱥ�в�����������Լ���ĸ������Լ������
    Chrom=adjustChrom(Chrom,w,p,cap);
    %% ��¼ÿ�ε�������������Ŀ�꺯��ֵ
    [cur_bestObj,cur_bestIndex]=max(Obj);       %�ڵ�ǰ����������Ŀ�꺯��ֵ�Լ���Ӧ����ı��
    cur_bestIndividual=Chrom(cur_bestIndex,:);  %��ǰ���������Ÿ���
    %�����ǰ����������Ŀ�꺯��ֵ���ڵ���ȫ������Ŀ�꺯��ֵ������и���
    if cur_bestObj>=bestObj
        bestObj=cur_bestObj;
        bestIndividual=cur_bestIndividual;
    end
    BestObj(gen,1)=bestObj;                     %��¼ÿ�ε�������������Ŀ�꺯��ֵ
    %% ��ӡÿ�ε��������е�ȫ�����Ž�
    disp(['��',num2str(gen),'�ε�����ȫ�����Ž�Ϊ��',num2str(bestObj)]);
    %% ���µ�������
    gen=gen+1 ;
end
%% ������������ͼ
figure;
plot(BestObj,'LineWidth',1);
xlabel('��������');
ylabel('Ŀ�꺯��ֵ����Ʒ�ܼ�ֵ��');
%% ����װ�����е���Ʒ���
pack_item=find(bestIndividual==1);
%% ��������װ����������Ʒ�ܼ�ֵ��������
[bestP,bestW]=Individual_P_W(n,bestIndividual,p,w);
toc