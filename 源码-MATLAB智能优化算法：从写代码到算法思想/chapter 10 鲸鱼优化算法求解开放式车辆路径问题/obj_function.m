%% ������Ⱥ��Ŀ�꺯��ֵ
%����population��  ������Ⱥ
%����cusnum��      �˿���Ŀ
%����cap��         �������װ����
%����demands��     �˿�������
%����dist��        �������
%����belta��       Υ��װ����Լ���ĳͷ�����ϵ��
%���obj��         ������Ⱥ��Ŀ�꺯��ֵ
function obj=obj_function(population,cusnum,cap,demands,dist,belta)
NIND=size(population,1);                   %��Ⱥ��Ŀ
obj=zeros(NIND,1);                         %����ÿ�����庯��ֵ
for i=1:NIND
    VC=decode(population(i,:),cusnum,cap,demands,dist);     %������������Ϊ���ͷ���
    costF=costFuction(VC,dist,demands,cap,belta);           %���㵱ǰ���ͷ�����Ŀ�꺯��ֵ
    obj(i)=costF;                                           %����ǰ���ͷ�����Ŀ�꺯��ֵ��ֵ����i���������Ŀ�꺯��ֵ
end
end