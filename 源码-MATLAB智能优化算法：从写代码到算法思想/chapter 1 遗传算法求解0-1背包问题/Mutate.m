%% �������
%����SelCh��               ��ѡ��ĸ���
%����Pm��                  �������
%���SelCh��               �����ĸ���
function SelCh=Mutate(SelCh,Pm)                     
[NSel,n]=size(SelCh);                               %nΪȾɫ�峤��
for i=1:NSel
    if Pm>=rand
        R=randperm(n);                              %�������1~n���������
        pos1=R(1);                                  %��1������λ��
        pos2=R(2);                                  %��2������λ��
        
        left=min([pos1,pos2]);                      %��С���Ǹ�ֵ��Ϊ�������
        right=max([pos1,pos2]);                     %������Ǹ�ֵ��Ϊ�����յ�
        
        mutate_Selch=SelCh(i,:);                    %��i�����б�������ĸ���
        mutate_part=mutate_Selch(right:-1:left);    %���б��������ı���Ƭ��
        mutate_Selch(left:right)=mutate_part;       %��mutate_Selch�ϵĵ�left��rightλ�ϵ�Ƭ�ν����滻
        
        SelCh(i,:)=mutate_Selch;                    %���µ�i�����б�������ĸ���
    end
end