%% ���룬��������Լ���ĸ���
%����n��                   ��Ʒ��Ŀ
%����w��                   ������Ʒ������
%����p��                   ������Ʒ�ļ�ֵ
%����cap��                 ������������
%���Individual��          ���㱳��������Լ���ĸ���
function Individual=encode(n,w,p,cap)
Individual=round(rand(1,n));                                %�������n�����֣�ÿ��������0��1��
flag=judge_individual(Individual,w,cap);                    %�ж�Individual�Ƿ����㱳����������Լ����1��ʾ���㣬0��ʾ������
%% ���flagΪ0������Ҫ�޸�����Individual�����򣬲���Ҫ�޸�
if flag==0
    Individual=repair_individual(Individual,w,p,cap);       %�޸�����Individual
end
end