%% ��һ���ζ���ת��Ϊ�����ζ����������ļ�ѡλ�ü���
%����batch��               һ���ζ���
%����orders��              ÿ����������������Ʒ��Ϣ
%���pickloc_set��         �����ζ����������ļ�ѡλ�ü���
function pickloc_set=batch_to_location(batch,orders)
order_num=numel(batch);                         %�����ζ���������������Ŀ
pickloc_set=[];                                 %��ʼ�����ζ����������ļ�ѡλ�ü���Ϊ�ռ�
for i=1:order_num
    pickloc_set=[pickloc_set,orders{batch(i)},1]; %�����ÿ����������������Ʒ�����ӵ�pick_set��
end
pickloc_set=unique(pickloc_set);                %ɾ���ظ���λ
end