tic
clear
clc
%% ��������
dataset=importdata('input.txt');                %�����У�ÿһ�еĺ���ֱ�Ϊ[��ţ�x���꣬y����]
x=dataset(:,2);                                 %x����
y=dataset(:,3);                                 %y����
vertexes=dataset(:,2:3);                        %��ȡ�������е�xy����
N=size(dataset,1);                              %������Ŀ
h=pdist(vertexes);                              %�����������֮��ľ��룬һ����1+2+......+(n-1)=n*(n-1)/2��
dist=squareform(h);                             %����������֮��ľ���ת��Ϊn��n�еľ������
%% ������ʼ��
MAXGEN=50;                                      %�������������
M=50;                                           %������M���������
n=3;                                            %������Ŀ
%% �����ʼ��
[init_route,init_len]=construct_route(dist);    %̰�������ʼ��
disp(['��ʼ·���ܾ���Ϊ',num2str(init_len)]);
cur_route=init_route;
best_route=cur_route;
best_len=route_length(cur_route,dist);
BestL=zeros(MAXGEN,1);                          %��¼ÿ�ε���������ȫ�����Ÿ�����ܾ���
%% ��ѭ��
gen=1;                                          %��������
while gen<=MAXGEN
    k=1;
    while(1)
        switch k
            case 1
                cur_route=shaking(cur_route,dist,k);
                [swap_route,swap_len]=swap_neighbor(cur_route,dist,M);
                cur_len=swap_len;
                if cur_len<best_len
                    cur_route=swap_route;
                    best_len=cur_len;
                    best_route=swap_route;
                    k=0;
                end
            case 2
                cur_route=shaking(cur_route,dist,k);
                [reversion_route,reversion_len]=reversion_neighbor(cur_route,dist,M);
                cur_len=reversion_len;
                if cur_len<best_len
                    cur_route=reversion_route;
                    best_len=cur_len;
                    best_route=reversion_route;
                    k=0;
                end
            case 3
                cur_route=shaking(cur_route,dist,k);
                [insertion_route,insertion_len]=insertion_neighbor(cur_route,dist,M);
                cur_len=insertion_len;
                if cur_len<best_len
                    cur_route=insertion_route;
                    best_len=cur_len;
                    best_route=insertion_route;
                    k=0;
                end
            otherwise
                break;
        end
        k=k+1;
    end
    disp(['��',num2str(gen),'������·���ܾ���Ϊ',num2str(best_len)]);
    BestL(gen,1)=best_len;
    %% ��������1
    gen=gen+1;
end
%% �����Ż�����ͼ
figure;
plot(BestL,'LineWidth',1);
title('�Ż�����')
xlabel('��������');
ylabel('�ܾ���');
%% ����ȫ������·��ͼ
plot_route(best_route,x,y);
toc