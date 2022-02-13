%% �Ծ�����Ⱥ���оֲ���������
%����population��      ������Ⱥ
%����cusnum��          �˿���Ŀ
%����cap��             �������װ����
%����demands��         �˿�������
%����dist��            �������
%����belta��           Υ��װ����Լ���ĳͷ�����ϵ��
%���population��      �ֲ�����������õ��ľ�����Ⱥ
function population=local_search(population,cusnum,cap,demands,dist,belta)
NIND=size(population,1);            %��Ⱥ��Ŀ
N=size(population,2);               %������峤��
newPopulation=zeros(NIND,N);        %��ʼ���ֲ�����������ľ�����Ⱥ
%% ��ԭʼ������Ⱥ��ÿ��������������ת����
for i=1:NIND
    newPopulation(i,:)=reversion(population(i,:));
end
%% ����Ŀ�꺯��ֵ
obj1=obj_function(population,cusnum,cap,demands,dist,belta);          %����ԭʼ������Ⱥ��Ŀ�꺯��ֵ
obj2=obj_function(newPopulation,cusnum,cap,demands,dist,belta);       %������ת����������Ⱥ��Ŀ�꺯��ֵ
%% ֻ��Ŀ�꺯��ֵ��С���Ż������ת������ľ������
index1=obj2<obj1;
population(index1,:)=newPopulation(index1,:);
%% ����ת������Population��ÿ�����������в������
for i=1:NIND
    newPopulation(i,:)=insertion(population(i,:));
end
%% ����Ŀ�꺯��ֵ
obj1=obj_function(population,cusnum,cap,demands,dist,belta);          %����ԭʼ������Ⱥ��Ŀ�꺯��ֵ
obj2=obj_function(newPopulation,cusnum,cap,demands,dist,belta);       %����������������Ⱥ��Ŀ�꺯��ֵ
%% ֻ��Ŀ�꺯��ֵ��С���Ż���ܲ��������ľ������
index2=obj2<obj1;
population(index2,:)=newPopulation(index2,:);
end