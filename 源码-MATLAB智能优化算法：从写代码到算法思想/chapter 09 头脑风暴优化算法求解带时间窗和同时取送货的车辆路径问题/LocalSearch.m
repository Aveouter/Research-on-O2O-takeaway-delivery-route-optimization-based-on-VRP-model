%% �ֲ���������
%����offspring��   ��ѡ������ɸ�����
%����cusnum��      �˿���Ŀ
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����cap��         �������װ����
%����a��           �˿�ʱ�䴰��ʼʱ��[a[i],b[i]]
%����b��           �˿�ʱ�䴰����ʱ��[a[i],b[i]]
%����L��           ��������ʱ�䴰����ʱ��
%����s��           �ͻ���ķ���ʱ��
%����dist��        �������
%����v��           ������ʻ�ٶ�
%���offspring��   �ֲ�����������ɸ�����
function offspring=LocalSearch(offspring,v_num,cusnum,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v)
D=15;                                                                           %Remove�����е����Ԫ��
toRemove=min(ceil(cusnum/2),15);                                                %��Ҫ�Ƴ��˿͵�����
[row,N]=size(offspring);
for i=1:row
    VC=decode(offspring(i,:),v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v); %������ת��Ϊ���ͷ���               
    [removed,rfvc]=Remove(cusnum,toRemove,D,dist,VC);                           %�ƻ�
    ReIfvc=Regret2Ins(removed,rfvc,demands,pdemands,cap,a,b,L,s,dist,v);        %�޸�
    CF=costFuction(VC,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v);         %�����޸�ǰ�ĸ���Ŀ�꺯��ֵ
    RCF=costFuction(ReIfvc,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v);    %�����޸���ĸ���Ŀ�꺯��ֵ
    if RCF<CF
        Individual=change(ReIfvc,N,cusnum);
        offspring(i,:)=Individual;
    end
end