%% ����滻��������
%����p_replace��   ��������滻һ���������ĵĸ���
%����cluster_num�� ������Ŀ
%����N��           ���峤��
%����order_cluster����ʼ�������ÿ������
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
%���order_cluster����ÿ�������еĸ��尴��Ŀ�꺯��ֵ������Ԫ������
function order_cluster=replace_center(p_replace,cluster_num,N,order_cluster,...
    v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta)
%% ��һ���ĸ��������m������������ѡ���һ���������ģ�����һ���²������������������ѡ�еľ�������
R1=rand(1,1);
if R1<=p_replace
    %���ѡ��һ����������
    repalce_cluster_num=randi([1,cluster_num],1,1);
    %�������һ����
    replace_solution=randperm(N);
    %��������²������������������ѡ�еľ�������
    order_cluster{repalce_cluster_num,1}(1,:)=replace_solution;
    %�����½��Ŀ�꺯��ֵ
    replace_solution_fitness=ObjFunction(replace_solution,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %���½��Ŀ�꺯��ֵ���浽order_cluster��
    order_cluster{repalce_cluster_num,2}(1,:)=replace_solution_fitness;
end
end