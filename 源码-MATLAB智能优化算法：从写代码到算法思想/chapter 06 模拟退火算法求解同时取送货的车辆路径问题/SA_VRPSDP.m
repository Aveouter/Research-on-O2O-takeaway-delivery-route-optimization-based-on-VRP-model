tic
clear
clc
%% ��importdata�����������ȡ�ļ� 
data=importdata('input.txt');
cap=200;
%% ��ȡ������Ϣ
vertexs=data(:,2:3);                %���е������x��y
customer=vertexs(2:end,:);          %�˿�����
cusnum=size(customer,1);            %�˿���
v_num=10;                           %�����������ʹ����Ŀ
demands=data(2:end,4);              %������
pdemands=data(2:end,5);             %������
h=pdist(vertexs);
dist=squareform(h);                 %�������
%% ģ���˻����
belta=100;                          %Υ����װ����Լ���ĳͷ�ϵ��
MaxOutIter=2000;                    %���ѭ������������
MaxInIter=300;                      %���ѭ������������
T0=1000;                            %��ʼ�¶�
alpha=0.99;                         %��ȴ����
pSwap=0.2;                          %ѡ�񽻻��ṹ�ĸ���
pReversion=0.5;                     %ѡ����ת�ṹ�ĸ���
pInsertion=1-pSwap-pReversion;      %ѡ�����ṹ�ĸ���
N=cusnum+v_num-1;                   %�ⳤ��=�˿���Ŀ+�������ʹ����Ŀ-1
%% ��������ʼ��
Scurr=randperm(N);                  %��������ʼ��
[currVC,NV,TD,violate_num,violate_cus]=decode(Scurr,v_num,cusnum,cap,demands,pdemands,dist);       %����ʼ��ת��Ϊ��ʼ���ͷ���
currCost=costFuction(currVC,dist,demands,pdemands,cap,belta);        %���ʼ���ͷ����ĳɱ�=������ʻ�ܾ���+belta*Υ����װ����Լ��֮��
Sbest=Scurr;                        %��ʼ��ȫ�����Ž⸳ֵΪ��ʼ��
bestVC=currVC;                      %��ʼ��ȫ���������ͷ�����ֵΪ��ʼ���ͷ���
bestCost=currCost;                  %��ʼ��ȫ�����Ž���ܳɱ���ֵΪ��ʼ���ܳɱ�
BestCost=zeros(MaxOutIter,1);       %��¼ÿһ��ȫ�����Ž���ܳɱ�
T=T0;                               %�¶ȳ�ʼ��
%% ģ���˻�
for outIter=1:MaxOutIter
    for inIter=1:MaxInIter
        Snew=Neighbor(Scurr,pSwap,pReversion,pInsertion);           %��������ṹ��������µĽ�
        newVC=decode(Snew,v_num,cusnum,cap,demands,pdemands,dist);  %���½�ת��Ϊ���ͷ���
        newCost=costFuction(newVC,dist,demands,pdemands,cap,belta); %���ʼ���ͷ����ĳɱ�=������ʻ�ܾ���+belta*Υ����װ����Լ��֮��
        %����½�ȵ�ǰ����ã�����µ�ǰ�⣬�Լ���ǰ����ܳɱ�
        if newCost<=currCost 
            Scurr=Snew; 
            currVC=newVC;
            currCost=newCost;
        else 
            %����½ⲻ�統ǰ��ã�������˻�׼����һ�����ʽ����½�
            delta=(newCost-currCost)/currCost;              %�����½��뵱ǰ���ܳɱ����İٷֱ�
            P=exp(-delta/T);                                %��������½�ĸ���
            %���0~1�������С��P��������½⣬�����µ�ǰ�⣬�Լ���ǰ���ܳɱ�
            if rand<=P
                Scurr=Snew; 
                currVC=newVC;
                currCost=newCost;
            end
        end
        %����ǰ����ȫ�����Ž���бȽϣ������ǰ����ã������ȫ�����Ž⣬�Լ�ȫ�����Ž��ܳɱ�
        if currCost<=bestCost
            Sbest=Scurr;
            bestVC=currVC;
            bestCost=currCost;
        end
    end
    %��¼���ѭ��ÿ�ε�����ȫ�����Ž���ܳɱ�
    BestCost(outIter)=bestCost;
    %��ʾ���ѭ��ÿ�ε�������ȫ�����Ž���ܳɱ�
    disp(['��',num2str(outIter),'��ȫ�����Ž�:'])
    [bestVC,bestNV,bestTD,best_vionum,best_viocus]=decode(Sbest,v_num,cusnum,cap,demands,pdemands,dist);
    disp(['����ʹ����Ŀ��',num2str(bestNV),'��������ʻ�ܾ��룺',num2str(bestTD),'��Υ��Լ��·����Ŀ��',num2str(best_vionum),'��Υ��Լ���˿���Ŀ��',num2str(best_viocus)]);
    fprintf('\n')
    %���µ�ǰ�¶�
    T=alpha*T;
end
%% ��ӡ���ѭ��ÿ�ε�����ȫ�����Ž���ܳɱ��仯����ͼ
figure;
plot(BestCost,'LineWidth',1);
title('ȫ�����Ž���ܳɱ��仯����ͼ')
xlabel('��������');
ylabel('�ܳɱ�');
%% ��ӡȫ�����Ž�·��ͼ
draw_Best(bestVC,vertexs);
toc