%% ��Υ��Լ���ĸ�������޸�
%����Individual��          ����
%����w��                   ������Ʒ������
%����p��                   ������Ʒ�ļ�ֵ
%����cap��                 ������������
%���Individual��          �޸���ĸ���
function Individual=repair_individual(Individual,w,p,cap)
%% �ж�һ�������Ƿ����㱳����������Լ����1��ʾ���㣬0��ʾ������
flag=judge_individual(Individual,w,cap);
%% ֻ�в�����Լ���ĸ���Ž����޸�
if flag==0
    %% �����޸�
    pack_item=find(Individual==1);                  %�ҳ�װ����������Ʒ�����
    num_pack=numel(pack_item);                      %װ����������Ʒ������Ŀ
    w_pack=w(pack_item);                            %�ҳ�װ����������Ʒ������
    total_w=sum(w_pack);                            %����װ����Ʒ��������
    p_pack=p(pack_item);                            %�ҳ�װ����������Ʒ�ļ�ֵ
    ratio_pack=p_pack./w_pack;                      %����װ����������Ʒ���Լ۱�=��ֵ/����
    [~,rps_index]=sort(ratio_pack);                 %���Ѿ�װ�����е���Ʒ�����Լ۱ȣ��Լ۱�=��ֵ?�������ɵ͵��߽�������
    %% ����rps_index˳�����ν���Ʒ�ӱ������Ƴ�
    for i=1:num_pack
        remove_item=pack_item(rps_index(i));        %���Ƴ�����Ʒ�����
        %����Ƴ�����Ʒ�����㱳����������Լ�����򽫸���Ʒ��Ӧ�Ļ���λ��Ϊ0��Ȼ����ֹѭ��
        if (total_w-w_pack(rps_index(i)))<=cap
            total_w=total_w-w_pack(rps_index(i));   %װ������Ʒ����������
            Individual(remove_item)=0;              %������Ʒ��Ӧ�Ļ���λ��Ϊ0
            break;
        else
            %����Ƴ�����Ʒ����Ȼ�����㱳����������Լ������ҲҪ������Ʒ��Ӧ�Ļ���λ��Ϊ0��Ȼ������Ƴ�������Ʒ
            total_w=total_w-w_pack(rps_index(i));   %װ������Ʒ����������
            Individual(remove_item)=0;              %������Ʒ��Ӧ�Ļ���λ��Ϊ0
        end
    end
    %% ��һ���޸�
    unpack_item=find(Individual==0);                %�ҳ���ʱδװ����������Ʒ�����
    num_unpack=numel(unpack_item);                  %��ʱδװ����������Ʒ������Ŀ
    w_unpack=w(unpack_item);                        %�ҳ���ʱδװ����������Ʒ������
    p_unpack=p(unpack_item);                        %�ҳ���ʱδװ����������Ʒ�ļ�ֵ
    ratio_unpack=p_unpack./w_unpack;                %�����ʱδװ����������Ʒ���Լ۱�=��ֵ/����
    [~,rups_index]=sort(ratio_unpack,'descend');    %����ʱδװ�����е���Ʒ�����Լ۱ȣ��Լ۱�=��ֵ?�������ɸߵ��ͽ�������
    %% ����rups_index˳�����ν���Ʒװ��
    for j=1:num_unpack
        pack_wait=unpack_item(rups_index(i));       %��װ����Ʒ���
        %���װ������Ʒ�����㱳����������Լ�����򽫸���Ʒ��Ӧ�Ļ���λ��Ϊ1��Ȼ�����װ��������Ʒ
        if (total_w+w_unpack(rups_index(i)))<=cap
            total_w=total_w+w_unpack(rups_index(i));%װ������Ʒ����������
            Individual(pack_wait)=1;                %������Ʒ��Ӧ�Ļ���λ��Ϊ1
        else
            %���װ������Ʒ�����㱳����������Լ��������ֹѭ��
            break;
        end
    end
end
end