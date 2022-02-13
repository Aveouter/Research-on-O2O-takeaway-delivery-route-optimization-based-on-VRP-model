%% ����ȫ������
%����Population��  ��Ⱥ
%����cluster_num�� ������Ŀ
%����cluster_row�� ÿ�������и������Ŀ
%����Idx��         ÿ����������Ӧ�����ھ���ı��
%����order_cluster����ÿ�������еĸ��尴��Ŀ�꺯��ֵ������Ԫ������
%����p_one��       ѡ��1������ĸ���
%����p_one_center��ѡ��1�������о������ĵĸ���
%����p_two_center��ѡ��2�������о������ĵĸ���
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
%���Population��  ���º����Ⱥ
function Population=update_Population(Population,cluster_num,cluster_row,Idx,order_cluster,p_one,p_one_center,p_two_center...
    ,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta)
NIND=size(Population,1);            %������Ŀ
%% ������NIND������
for i=1:NIND
    %��������С��ѡ��1������ĸ��ʣ������ѡ��1������
    if rand()<p_one
        select_one_cluster=randi([1,cluster_num],1,1); %ѡ��ѡ��һ������
        %��������С��ѡ��1�������о������ĵĸ��ʣ���ǰ������ֻ��һ������
        if rand()<p_one_center||cluster_row(select_one_cluster)==1
            select_ind=order_cluster{select_one_cluster,1}(1,:);        %ѡ��ǰ��ľ������ģ�ֻ��һ������ʱ����ѡ��ø��壩
        else
            r_1= randi([2,cluster_row(select_one_cluster)],1,1);        %���ѡ��ǰ�����г�����������������������
            select_ind=order_cluster{select_one_cluster,1}(r_1,:);      %���ѡ��ǰ�����г��������������������
        end
        indi_temp=Swap(select_ind);                                     %���ø�����н�������
    else %����������С��ѡ��1������ĸ��ʣ������ѡ��2������
        cluster_two=[0,0];                                              %�������������������
        while cluster_two(1,1)==cluster_two(1,2)
            cluster_two=randi([1,cluster_num],1,2);                     %������������Ų�����ͬ
        end
        %��������С��ѡ��2�������о������ĵĸ��ʣ���ǰ���������ж�ֻ��һ������
        if (rand()<p_two_center)||(cluster_row(cluster_two(1,1))==1&&cluster_row(cluster_two(1,2))==1)
            %ѡ����2�������о�������
            select_ind1=order_cluster{cluster_two(1,1),1}(1,:);      %��һ����ѡ��ľ�������
            select_ind2=order_cluster{cluster_two(1,2),1}(1,:);      %�ڶ�����ѡ��ľ�������
        else
            %�����1��ѡ��ľ�����ֻ��һ������
            if cluster_row(cluster_two(1,1))==1
                r_2=randi([2,cluster_row(cluster_two(1,2))],1,1);        %ѡ���2�������г��������������������
                select_ind1=order_cluster{cluster_two(1,1),1}(1,:);      %��һ�������б�ѡ��ĸ���
                select_ind2=order_cluster{cluster_two(1,2),1}(r_2,:);    %�ڶ��������б�ѡ��ĸ���
            elseif cluster_row(cluster_two(1,2))==1  %�����2��ѡ��ľ�����ֻ��һ������
                r_3=randi([2,cluster_row(cluster_two(1,1))],1, 1);        %ѡ���1�������г��������������������
                select_ind1=order_cluster{cluster_two(1,1),1}(r_3,:);     %��һ�������б�ѡ��ĸ���
                select_ind2=order_cluster{cluster_two(1,2),1}(1,:);       %�ڶ��������б�ѡ��ĸ���
            elseif cluster_row(cluster_two(1,1))>1&&cluster_row(cluster_two(1,2))>1
                %%ѡ����2�������г��������������������
                r_4=randi([2,cluster_row(cluster_two(1,1))],1,1);
                r_5=randi([2,cluster_row(cluster_two(1,2))],1,1);
                select_ind1=order_cluster{cluster_two(1,1),1}(r_4,:);       %��һ�������б�ѡ��ĸ���
                select_ind2=order_cluster{cluster_two(1,2),1}(r_5,:);       %�ڶ��������б�ѡ��ĸ���
            end
        end
        [child1,child2]=OX(select_ind1,select_ind2);                        %����
        Obj1=ObjFunction(child1,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
        Obj2=ObjFunction(child2,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
        %����Ӵ�����1Ŀ�꺯��ֵ��С����indi_temp��ֵΪchild1������ֵΪchild2
        if Obj1<Obj2
            indi_temp=child1;
        else
            indi_temp=child2;
        end
    end
    fit_indi_temp=ObjFunction(indi_temp,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %���fit_indi_temp��ԭ��λ���ϵĸ���Ŀ�꺯��ֵ��С������¸�λ���ϵĸ���
    if fit_indi_temp<order_cluster{Idx(i),2}(1,:)
        Population(i,:) =indi_temp(1,:);
    end
end
end