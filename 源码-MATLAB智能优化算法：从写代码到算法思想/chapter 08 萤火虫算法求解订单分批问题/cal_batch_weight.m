%% ����ĳһ���ζ�������װ����
%����batch��            ��ǰ��������
%����orders��           ÿ����������������Ʒ��Ϣ
%����item_weight��      ÿ����λ����Ʒ������
%���batch_weight��     ��������װ����
function batch_weight=cal_batch_weight(batch,orders,item_weight)
order_num=numel(batch);                     %�����ζ����������Ķ�����Ŀ
batch_weight=0;                             %��ʼ�����ζ�����������Ʒװ����Ϊ0
for i=1:order_num
    order_no=batch(i);                      %�������ж����ı��
    item_set=orders{order_no};              %�ö�������������Ʒ���
    item_num=numel(item_set);               %�ö�������������Ʒ��Ŀ
    for j=1:item_num
        batch_weight=batch_weight+item_weight(item_set(j)); %����ǰ��Ʒ�����ӵ���װ������
    end
end
end