tic
clear
clc
%% ��importdata�����������ȡ�ļ� 
dataset=importdata('input.txt');
cap=200;
%% ��ȡ������Ϣ
vertexs=dataset(:,2:3);                                         %���е������x��y
customer=vertexs(2:end,:);                                      %�˿�����
cusnum=size(customer,1);                                        %�˿���
demands=dataset(2:end,4);                                       %������
h=pdist(vertexs);
dist=squareform(h);                                             %�ɱ�����
%% ��ʼ������
m=50;                                                           %��������
alpha=1;                                                        %��Ϣ����Ҫ�̶�����
beta=5;                                                         %����������Ҫ�̶�����
rho=0.85;                                                       %��Ϣ�ػӷ�����
Q=5;                                                            %������Ϣ��Ũ�ȵĳ���
Eta=1./dist;                                                    %��������
Tau=ones(cusnum+1,cusnum+1);                                    %��Ϣ�ؾ���
Table=zeros(m,cusnum);                                          %·����¼��
iter=1;                                                         %����������ֵ
iter_max=100;                                                   %����������
Route_best=zeros(iter_max,cusnum);                              %�������·��
Cost_best=zeros(iter_max,1);                                    %�������·���ĳɱ�
%% ����Ѱ�����·��
while iter<=iter_max
    %% �ȹ������������ϵ�·��
    %�������ѡ��
    for i=1:m
        %����˿�ѡ��
        for j=1:cusnum
            np=next_point(i,Table,Tau,Eta,alpha,beta,dist,cap,demands);
            Table(i,j)=np;
        end
    end
    %% ����������ϵĳɱ�=1000*����ʹ����Ŀ+������ʻ�ܾ���
    cost=zeros(m,1);
    NV=zeros(m,1);
    TD=zeros(m,1);
    for i=1:m
        VC=decode(Table(i,:),cap,demands,dist);
        [cost(i,1),NV(i,1),TD(i,1)]=costFun(VC,dist);
    end
    %% ������С�ɱ���ƽ���ɱ�
    if iter == 1
        [min_Cost,min_index]=min(cost);
        Cost_best(iter)=min_Cost;
        Route_best(iter,:)=Table(min_index,:);
    else
        [min_Cost,min_index]=min(cost);
        Cost_best(iter)=min(Cost_best(iter - 1),min_Cost);
        if Cost_best(iter)==min_Cost
            Route_best(iter,:)=Table(min_index,:);
        else
            Route_best(iter,:)=Route_best((iter-1),:);
        end
    end
    %% ������Ϣ��
    bestR=Route_best(iter,:);
    [bestVC,bestNV,bestTD]=decode(bestR,cap,demands,dist);
    Tau=updateTau(Tau,bestR,rho,Q,cap,demands,dist);
    %% ��ӡ��ǰ���Ž�
    disp(['��',num2str(iter),'�����Ž�:'])
    disp(['����ʹ����Ŀ��',num2str(bestNV),'��������ʻ�ܾ��룺',num2str(bestTD)]);
    fprintf('\n')
    %% ����������1�����·����¼��
    iter=iter+1;
    Table=zeros(m,cusnum);
end
%% �����ʾ
bestRoute=Route_best(end,:);
[bestVC,bestNV,bestTD]=decode(bestRoute,cap,demands,dist);
draw_Best(bestVC,vertexs);
%% ��ͼ
figure(2)
plot(1:iter_max,Cost_best,'b')
xlabel('��������')
ylabel('�ɱ�')
title('������С�ɱ��仯����ͼ')
toc