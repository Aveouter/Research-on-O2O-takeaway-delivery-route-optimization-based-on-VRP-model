tic
clear
clc
%% ���붩�����ݺ͸�����λ��Ʒ����������
load orders.mat orders
load item_weight.mat item_weight
%% �ֿ������ʼ��
depot_leftAisle=1.5;        %�ֿ����1����ѡͨ���ľ��룬1.5LU
enter_leave_aisle=1;        %��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
adjacent_location=1;        %ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
adjacent_aisle=5;           %�������ڼ�ѡͨ���ľ��룬5LUs
aisle_num=10;               %��ѡͨ����Ŀ
side_num=15;                %ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
capacity=100;               %�豸���װ��������λkg
%% �����������ݳ�ʼ��
orders_num=20;              %������Ŀ
batches_maxnum=10;          %��������������Ŀ
%% ө����㷨������ʼ��
MAXGEN=100;                         %����������
NIND=50;                            %ө�����Ŀ
N=batches_maxnum+orders_num-1;      %���볤��
alpha=2000;                         %Υ���豸װ����Լ���ĳͷ�����
gama=0.95;                          %������ϵ��
%% ��ʼ��
Population=init_pop(NIND,N);        %�����ʼ��
best_firefly=Population(1,:);       %��ʼȫ������
[batches,batches_num,bestTD,violate_batch,violate_order]=decode(best_firefly,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
disp(['��ʼ����������Ŀ��',num2str(batches_num),'������ʻ���룺',num2str(bestTD),...
    '��Υ��Լ������������Ŀ��',num2str(violate_batch),'��Υ��Լ��������Ŀ��',num2str(violate_order)]);
best_cost=cost_function(batches,orders,item_weight,capacity,side_num,depot_leftAisle,...
    enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);   %��ʼȫ�����ŷ�������������ʻ����
Best_Cost=zeros(MAXGEN,1);          %��¼ÿһ�ε���ȫ�������ܾ���
Best_TD=zeros(MAXGEN,1);          %��¼ÿһ�ε���ȫ�������ܾ���
%% ��ѭ��
gen=1;
while gen<=MAXGEN
    %% ������ȺĿ�꺯��ֵ
    Obj=obj_function(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
    %% ����ө���λ��
    for i=1:NIND
        Individual1=Population(i,:);                    %��i��ө���
        for j=1:NIND
            Individual2=Population(j,:);            %��j��ө���
            %�����j��ө��淢��ǿ�ȸ�������Ҫ����i��ө������j��ө��濿��
            if Obj(j,1)<Obj(i,1)
                rij=cal_rij(Individual1,Individual2);   %��������ө���֮��ľ���
                cross_len=randi([1,ceil(rij*gama^gen)],1,1);    %���㽻��Ƭ�γ���
                [Individual1,Individual2]=crossover(Individual1,Individual2,cross_len);     %����������õ��µĵ�i��ө���
                newObj1=obj_function(Individual1,orders,batches_maxnum,orders_num,capacity,item_weight,...
                    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);%�����õ�����ө���
                if newObj1<Obj(i,1)
                    Population(i,:)=Individual1;                     %��������Ⱥ��i��ө���λ��
                    Obj(i,1)=newObj1;
                    %��������Ⱥ�е�i��ө����Ŀ�꺯��ֵ
                end
            end
        end
    end
    %% �Ӹ��º��Population��ѡ��Ŀ�꺯��ֵ��ǰ10%�ĸ���
   offspring=select(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
    %% �ֲ�����
    offspring=local_search(offspring,orders,batches_maxnum,orders_num,capacity,item_weight,alpha,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    %% ���ֲ��������offspring��ԭ����Population���кϲ�
    Population=merge(Population,offspring,Obj);
    %% �ҵ�ȫ�����ŵ�ө���
    Obj=obj_function(Population,orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle,alpha);
    [min_Obj,min_index]=min(Obj);                              %���ڵ�1λ������СĿ�꺯��ֵ
    if min_Obj<best_cost
        best_firefly=Population(min_index,:);                   %����ȫ������ө���
        best_cost=min_Obj;
    end
    Best_Cost(gen,1)=best_cost;                   %��¼ÿ�ε���ȫ������Ŀ�꺯��ֵ
    %% ��ӡ
    [best_batches,batches_num,bestTD,violate_batch,violate_order]=decode(best_firefly,orders,batches_maxnum,orders_num,capacity,item_weight,...
        side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
    disp(['��',num2str(gen),'��ȫ������ө��涩��������Ŀ��',num2str(batches_num),'������ʻ���룺',num2str(bestTD),...
        '��Υ��Լ������������Ŀ��',num2str(violate_batch),'��Υ��Լ��������Ŀ��',num2str(violate_order)]);
    %% ��¼ȫ�����������߾���
    Best_TD(gen,1)=bestTD;
    %% ��������1
    gen=gen+1;
end
%% ����Ż�����ͼ
figure;
plot(Best_TD,'LineWidth',1);
title('�Ż�����')
xlabel('��������');
ylabel('��ѡ�����߾���');
%% ��ȫ������ө������Ϊ������������
[best_batches,best_num,bestTD]=decode(best_firefly,orders,batches_maxnum,orders_num,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
toc