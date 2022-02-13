tic
clear
clc
%% ��xlsread��������ȡxlsx�ļ�
data=xlsread('ʵ����֤����.xlsx','ת��������','A2:H17');
cap=150;                            %�������װ����
v=30/60;                            %������ʻ�ٶ�=30km/h=30/60km/min
%% ��ȡ������Ϣ
E=data(1,6);                        %��������ʱ�䴰��ʼʱ��
L=data(1,7);                        %��������ʱ�䴰����ʱ��
vertexs=data(:,2:3);                %���е������x��y
customer=vertexs(2:end,:);          %�˿�����
cusnum=size(customer,1);            %�˿���
v_num=10;                           %�����������ʹ����Ŀ
demands=data(2:end,4);              %������
pdemands=data(2:end,5);             %������
a=data(2:end,6);                    %�˿�ʱ�䴰��ʼʱ��[a[i],b[i]]
b=data(2:end,7);                    %�˿�ʱ�䴰����ʱ��[a[i],b[i]]
s=data(2:end,8);                    %�ͻ���ķ���ʱ��
h=pdist(vertexs);
dist=squareform(h);                 %�������
N=cusnum+v_num-1;                   %�ⳤ��=�˿���Ŀ+�������ʹ����Ŀ-1
%% ������ʼ��
alpha=10;                           %Υ��������Լ���ĳͷ�����ϵ��
belta=100;                          %Υ��ʱ�䴰Լ���ĳͷ�����ϵ��
MAXGEN=150;                         %����������
NIND=50;                            %��Ⱥ��Ŀ
cluster_num=5;                      %������Ŀ
p_replace=0.1;                      %��������滻һ���������ĵĸ���
p_one=0.5;                          %ѡ��1������ĸ���
p_two=1-p_one;                      %ѡ��2������ĸ��ʣ�p_two=1-p_one
p_one_center=0.3;                   %ѡ��1�������о������ĵĸ���
p_two_center=0.2;                   %ѡ��2�������о������ĵĸ���
%% ��Ⱥ��ʼ��
Population=InitPop(NIND,N);
%% ��ѭ��
gen=1;                              %��������ʼ��
bestInd=Population(1,:);            %��ʼ��ȫ�����Ÿ���
bestObj=ObjFunction(bestInd,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);  %��ʼȫ�����Ÿ����Ŀ�꺯��ֵ
BestPop=zeros(MAXGEN,N);            %��¼ÿ�ε���������ȫ�����Ÿ���
BestObj=zeros(MAXGEN,1);            %��¼ÿ�ε���������ȫ�����Ÿ����Ŀ�꺯��ֵ 
BestTD=zeros(MAXGEN,1);            %��¼ÿ�ε���������ȫ�����Ÿ�����ܾ���
while gen<=MAXGEN
    %% ����Ŀ�꺯��ֵ
    Obj=ObjFunction(Population,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %% K-means����
    Idx=kmeans(Obj,cluster_num,'Distance','cityblock','Replicates',2);
    cluster=cell(cluster_num,2);                    %���ⴢ����ÿһ��������
    order_cluster=cell(cluster_num,2);              %��������ÿһ�������еĸ��尴��Ŀ�꺯��ֵ����
    for i=1:cluster_num
        cluster{i,1}=Population(Idx==i,:);          %�����尴�������ľ����Ŵ��浽��Ӧ�ľ�����
        cluster_row(i)=size(cluster{i,1},1);           %���㵱ǰ�����и�����Ŀ
        for j=1:cluster_row(i)
            Individual=cluster{i,1}(j,:);           %��ǰ�����е�j������
            %���㵱ǰ�����е�j�������Ŀ�꺯��ֵ
            cluster{i,2}(j,1)=ObjFunction(Individual,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
        end
        [order_cluster{i,2},order_index]=sort(cluster{i,2}) ; %����ǰ�����е����и��尴��Ŀ�꺯��ֵ��С�����˳���������
        order_cluster{i,1}=cluster{i,1}(order_index,:); %����ǰ�����е����и��尴����������������
        order_index=0;                                  %�����������
    end
    cluster_fit=cell2mat(order_cluster);                %�������Ԫ������ת��Ϊ�������һ��Ϊ�����Ŀ�꺯��ֵ
    %% ��һ���ĸ��������m������������ѡ���һ���������ģ�����һ���²������������������ѡ�еľ�������
    order_cluster=replace_center(p_replace,cluster_num,N,order_cluster,...
    v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %% ������n������
    Population=update_Population(Population,cluster_num,cluster_row,Idx,order_cluster,p_one,p_one_center,p_two_center...
    ,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %% ����ԭʼPopulation��Ŀ�꺯��ֵ
    Obj=ObjFunction(Population,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %% �Ӹ��º��Population��ѡ��Ŀ�꺯��ֵ��ǰ50%�ĸ���
    offspring=select(Population,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %% ��ѡ����ĸ�����оֲ���������
    offspring=LocalSearch(offspring,v_num,cusnum,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v);
    %% ���ֲ��������offspring��ԭ����Population���кϲ�
    Population=merge(Population,offspring,Obj);
    %% ����ϲ����Population��Ŀ�꺯��ֵ
    mObj=ObjFunction(Population,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %% �ҳ��ϲ����Population�е����Ÿ���
    [min_len,min_index]=min(mObj);               %��ǰ��Ⱥ�����Ÿ����Լ�����Ӧ�����
    %�����ǰ�������Ÿ���Ŀ�꺯��ֵС��ȫ������Ŀ�꺯��ֵ�������ȫ�����Ÿ���
    if min_len<bestObj
        bestObj=min_len;
        bestInd=Population(min_index,:);
    end
    %% ��ӡ�������Ž�
    disp(['��',num2str(gen),'�����Ž�:'])
    [bestVC,bestNV,bestTD,best_vionum,best_viocus]=decode(bestInd,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v);
     disp(['Ŀ�꺯��ֵ��',num2str(bestObj),'������ʹ����Ŀ��',num2str(bestNV),'��������ʻ�ܾ��룺',num2str(bestTD),'��Υ��Լ��·����Ŀ��',num2str(best_vionum),'��Υ��Լ���˿���Ŀ��',num2str(best_viocus)]);
    fprintf('\n')
    %% ����ȫ�����Ÿ���
    BestObj(gen,1)=bestObj;                     %��¼ȫ�����Ÿ����Ŀ�꺯��ֵ 
    BestPop(gen,:)=bestInd;                     %��¼ȫ�����Ÿ���
    BestTD(gen,1)=bestTD;                       %��¼ȫ�����Ÿ�����ܾ��� 
    %% ��������1
    gen=gen+1;
end
%% ������������·��ͼ
draw_Best(bestVC,vertexs);
%% ��ӡÿ�ε�����ȫ�����Ÿ�����ܾ���仯����ͼ
figure;
plot(BestTD,'LineWidth',1);
title('�Ż�����')
xlabel('��������');
ylabel('���ͷ�����ʻ�ܾ���');
toc