%% ��removed�еĶ�����ظ�����������
%����removed��             ���Ƴ������ļ���
%����r_batches��           �Ƴ����ɸ�������Ķ�����������
%����orders��              ÿ����������������Ʒ��Ϣ
%����capacity��            �豸���װ����
%����item_weight��         ÿ����λƷ�������
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ��ͨ�������ѡͨ����Ӽ�ѡͨ������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���p_batches��           �޸���Ķ�����������
function p_batches=greedy_ins(removed,r_batches,orders,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
%��removed�ж������ռ�ѡ���߾����ɴ�С����
removed=removed_down_sort(removed,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
p_batches=r_batches;            %��ʼ���޸���Ķ�������������ֵΪ�ƻ���Ķ�����������
nr=numel(removed);              %�Ƴ������ж�����Ŀ
ri_no=zeros(nr,1);              %�洢��removed�и����������ʱ����Ѳ�ض������α��
ri_cost=zeros(nr,1);            %�洢��removed�и����������ʱ����Ѳ���ɱ�
ri_batch=cell(nr,1);            %�洢��removed�и����������ʱ����Ѳ�صĶ�������
%% ��removed�еĸ������������ص�ǰ��������������
for i=1:nr
    order=removed(i);           %��ǰҪ��صĶ���
    dec=[];                     %��¼order�Ĳ���ɱ�
    ins_no=[];                  %��¼order���Բ�صĶ����������
    count=1;                    %������
    ins_b=cell(count,1);    %��¼order���Բ�صĶ������ν��
    for j=1:size(p_batches,1)
        batch=p_batches{j};     %��j���ζ�������
        [new_batch,flag,deltaC]=ins_batch(order,orders,batch,capacity,item_weight,...
            side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
        %flag=1��ʾ�ܲ��룬flag=0��ʾ���ܲ���
        if flag==1
            ins_b{count,1}=new_batch;
            dec=[dec;deltaC];
            ins_no=[ins_no;j];
            count=count+1;      %����������
        end
    end
    %�����������Լ����ins_batch������²�ض������α��ri_no����Ѳ���ɱ�ri_cost����صĶ�������ri_batch
    if ~isempty(ins_no)
        [sd,sdi]=sort(dec);                 %��dec��������
        insc=ins_no(sdi);                   %��ins_no�������dec��������Ŷ�Ӧ
        ri_no(i)=insc(1);                   %����order���ʱ����Ѳ�ض������α��
        ri_cost(i)=sd(1);                   %���²��ʱ����Ѳ���ɱ�
        ri_batch{i}=ins_b{sdi(1)};      %���²��ʱ����Ѳ�صĶ�������
    else
        %�������������Լ����ins_batch����������һ���ζ���
        ri_no(i)=size(p_batches,1)+1;       %������һ���ζ���
        ri_cost(i)=shpath(order,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
        ri_batch{i}=order;
    end
    r_ins=ri_no(i);                         %��ض������εı��
    p_batches{r_ins}=ri_batch{i};           %����p_batches
end
end