%% �������
%����SelCh��               ��ѡ��ĸ���
%����Pc��                  �������
%���SelCh��               �����ĸ���
function SelCh=Crossover(SelCh,Pc)
[NSel,n]=size(SelCh);                               %nΪȾɫ�峤��
for i=1:2:NSel-mod(NSel,2)
    if Pc>=rand %�������Pc
        cross_pos=unidrnd(n);                       %�������һ��1~N֮��Ľ���λ��
        
        cross_Selch1=SelCh(i,:);                    %��i�����н�������ĸ���
        cross_Selch2=SelCh(i+1,:);                  %��i+1�����н�������ĸ���
        
        cross_part1=cross_Selch1(1:cross_pos);      %��i�����н����������Ľ���Ƭ��
        cross_part2=cross_Selch2(1:cross_pos);      %��i+1�����н����������Ľ���Ƭ��
        
        cross_Selch1(1:cross_pos)=cross_part2;      %�õ�i+1������Ľ���Ƭ���滻����i�����彻��Ƭ��
        cross_Selch2(1:cross_pos)=cross_part1;      %�õ�i������Ľ���Ƭ���滻����i+1�����彻��Ƭ��
        
        SelCh(i,:)=cross_Selch1;                    %���µ�i������
        SelCh(i+1,:)=cross_Selch2;                  %���µ�i+1������
    end
end