%% ������ȺĿ�꺯��ֵ����ÿ���������������ͷ������ܳɱ�
%����Population��  ��Ⱥ
%����v_num��       �����������ʹ����Ŀ
%����cusnum��      �˿���Ŀ
%����cap��         �������װ����
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����a,b��         �˿�ʱ�䴰����ʱ��[a[i],b[i]]
%����s��           ��ÿ���˿͵ķ���ʱ��
%����L��           �ֿ�ʱ�䴰����ʱ��
%����dist��        �������
%����v��           ������ʻ�ٶ�
%����alpha��       Υ����װ����Լ���ĳͷ�����ϵ��
%����belta��       Υ��ʱ�䴰Լ���ĳͷ�����ϵ��
%���Obj��         ÿ�������Ŀ�꺯��ֵ
function Obj=ObjFunction(Population,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta)
NIND=size(Population,1);                                                        %��Ⱥ��С
Obj=zeros(NIND,1);                                                              %Ŀ�꺯����ʼ��Ϊ0
for i=1:NIND
    Individual=Population(i,:);                                                 %��ǰ����
    VC=decode(Individual,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v);     %������ת��Ϊ���ͷ���
    Obj(i,1)=costFuction(VC,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v);   %���㵱ǰ������ܳɱ�
end
end