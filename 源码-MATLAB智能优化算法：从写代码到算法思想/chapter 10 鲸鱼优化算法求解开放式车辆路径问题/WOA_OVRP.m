tic
clear
clc
%% ��importdata�����������ȡ�ļ�
data=importdata('input.txt');
cap=160;
%% ��ȡ������Ϣ
vertexs=data(:,2:3);                %���е������x��y
customer=vertexs(2:end,:);          %�˿�����
cusnum=size(customer,1);            %�˿���
v_num=3;                            %��ʼ����ʹ����Ŀ
demands=data(2:end,4);              %������
h=pdist(vertexs);
dist=squareform(h);                 %�������
%% �����Ż��㷨����
NIND=100;                           %��Ⱥ��Ŀ
MAXGEN=300;                         %����������
N=cusnum+v_num-1;                   %������峤��=�˿���Ŀ+�������ʹ����Ŀ-1
belta=10;                           %Υ��װ����Լ���ĳͷ�����ϵ��
%% ��Ⱥ��ʼ��
init_vc=init(cusnum,demands,cap,dist);          %����OVRP��ʼ��
population=init_pop(NIND,N,cusnum,init_vc);
%% ���������·�ߺ��ܾ���
obj=obj_function(population,cusnum,cap,demands,dist,belta);
[min_obj,min_index]=min(obj);
disp('��ʼ��Ⱥ�е����Ÿ���:')
[currVC,NV,TD,violate_num,violate_cus]=decode(population(min_index,:),cusnum,cap,demands,dist);       %�Գ�ʼ�����
disp(['����ʹ����Ŀ��',num2str(NV),'��������ʻ�ܾ��룺',num2str(TD),'��Υ��Լ��·����Ŀ��',num2str(violate_num),'��Υ��Լ���˿���Ŀ��',num2str(violate_cus)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%% ��ѭ��
gen=1;                              %��������ʼ��
bestInd=population(min_index,:);    %��ʼ��ȫ�����Ÿ���
bestObj=min_obj;                    %��ʼȫ�����Ÿ���Ŀ�꺯��ֵ
BestPop=zeros(MAXGEN,N);            %��¼ÿ�ε���������ȫ�����Ÿ���
BestObj=zeros(MAXGEN,1);            %��¼ÿ�ε���������ȫ�����Ÿ����Ŀ�꺯��ֵ
BestTD=zeros(MAXGEN,1);             %��¼ÿ�ε���������ȫ�����Ÿ�����ܾ���
while gen<=MAXGEN
    %% ���¾�����Ⱥλ��
    for i=1:NIND
        p=rand;        %0~1֮��������
        if p<0.5
            population(i,:)=cross1(population(i,:),bestInd,cusnum,cap,demands,dist,belta);
        elseif p>=0.5
            population(i,:)=cross2(population(i,:),bestInd,cusnum,cap,demands,dist,belta);
        end
    end
    %% �ֲ���������
    population=local_search(population,cusnum,cap,demands,dist,belta);
    %% ���㵱ǰ������ȺĿ�꺯��ֵ
    obj=obj_function(population,cusnum,cap,demands,dist,belta);
    [min_obj,min_index]=min(obj);
    minInd=population(min_index,:);
    %% ����ȫ�����ž������
    if min_obj<bestObj
        bestInd=minInd;
        bestObj=min_obj;
    end
    BestPop(gen,:)=bestInd;
    BestObj(gen,1)=bestObj;
    %% ��ʾ��ǰȫ�����ž���������������ͷ�����Ϣ
    disp(['��',num2str(gen),'��ȫ�����Ž�:'])
    [bestVC,bestNV,bestTD,best_vionum,best_viocus]=decode(bestInd,cusnum,cap,demands,dist);
    disp(['����ʹ����Ŀ��',num2str(bestNV),'��������ʻ�ܾ��룺',num2str(bestTD),'��Υ��Լ��·����Ŀ��',num2str(best_vionum),'��Υ��Լ���˿���Ŀ��',num2str(best_viocus)]);
    fprintf('\n')
    BestTD(gen,1)=bestTD;
    %% ���¼�����
    gen=gen+1;
end
%% ��ӡ���ѭ��ÿ�ε�����ȫ�����Ž���ܳɱ��仯����ͼ
figure;
plot(BestObj,'LineWidth',1);
title('ȫ�����ž������Ŀ�꺯��ֵ�仯����ͼ')
xlabel('��������');
ylabel('Ŀ�꺯��ֵ');
%% ��ӡȫ�����Ž�·��ͼ��1��ʾ���㣬0��ʾ������
draw_Best(bestVC,vertexs);
toc