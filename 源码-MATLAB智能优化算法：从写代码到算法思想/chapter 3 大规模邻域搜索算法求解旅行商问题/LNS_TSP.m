tic
clear
clc
%% ��������
dataset=importdata('input.txt');                %�����У�ÿһ�еĺ���ֱ�Ϊ[��ţ�x���꣬y����]
x=dataset(:,2);                                 %x����
y=dataset(:,3);                                 %y����
vertexes=dataset(:,2:3);                        %��ȡ�������е�xy����
h=pdist(vertexes);
dist=squareform(h);                             %�������
%% ������ʼ��
MAXGEN=300;                                     %����������
%% �����ʼ��
[Sinit,init_len]=construct_route(dist);         %̰�������ʼ��
init_length=route_length(Sinit,dist);
str1=['��ʼ��·�߳��� =  ' num2str(init_length)];
disp(str1)
%% ��ʼ����ǰ���ȫ�����Ž�
Scurr=Sinit;
curr_length=init_length;
Sbest=Sinit;
best_length=init_length;
%% ��ѭ��
gen=1;
BestL=zeros(MAXGEN,1);                          %��¼ÿ�ε���������ȫ�����Ÿ�����ܾ���
while gen<=MAXGEN
    %% ���ƻ�����
    [Sdestroy,removed]=destroy(Scurr);
    %% ���޸�����
    [Srepair,repair_length]=repair(removed,Sdestroy,dist);
    if repair_length<curr_length
        Scurr=Srepair;
        curr_length=repair_length;
    end
    if curr_length<best_length
        Sbest=Scurr;
        best_length=curr_length;  
    end
    %% ��ӡ��ǰ��ȫ�����Ž�
    disp(['��',num2str(gen),'������·���ܳ��� =  ' num2str(best_length)])
    BestL(gen,1)=best_length;
    %% ��������1
    gen=gen+1;
end
str2=['������ɣ� ����·���ܳ��� =  ' num2str(best_length)];
disp(str2)
%% �����Ż�����ͼ
figure;
plot(BestL,'LineWidth',1);
title('�Ż�����')
xlabel('��������');
ylabel('�ܾ���');
%% ����ȫ������·��ͼ
plot_route(Sbest,x,y);
toc