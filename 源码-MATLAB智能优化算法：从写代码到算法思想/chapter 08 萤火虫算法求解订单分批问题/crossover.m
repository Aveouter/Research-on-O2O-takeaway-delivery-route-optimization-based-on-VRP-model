%% �������
%����firefly1��            ө������1
%����firefly2��            ө������2
%����cross_len��           ���泤�ȣ����ڵ���2
%���firefly1��            ������ө������1
%���firefly2��            ������ө������2
function [firefly1,firefly2]=crossover(firefly1,firefly2,cross_len)
N=numel(firefly1);              %ө��������볤��
range=N-cross_len+1;            %��ʼ�����ѡ��Χ
s=randi([1,range],1,1);         %���ѡ����ʼ��
e=s+cross_len-1;                %���ݽ��泤�ȣ�ȷ�������յ�
a0=[firefly2(s:e),firefly1];    %��ө���2�Ľ���Ƭ���ƶ���ө���1ǰ
b0=[firefly1(s:e),firefly2];    %��ө���1�Ľ���Ƭ���ƶ���ө���2ǰ
for i=1:numel(a0)
    aindex=find(a0==a0(i));
    bindex=find(b0==b0(i));
    if numel(aindex)>1
        a0(aindex(2))=[];       %��ө���1�����е�2���ظ���Ԫ��ɾ��
    end
    if numel(bindex)>1
        b0(bindex(2))=[];       %��ө���1�����е�2���ظ���Ԫ��ɾ��
    end
    if i==numel(firefly1)
        break
    end
end
firefly1=a0;                    %ɾ���ظ�Ԫ�ص�ө������1
firefly2=b0;                    %ɾ���ظ�Ԫ�ص�ө������2
end