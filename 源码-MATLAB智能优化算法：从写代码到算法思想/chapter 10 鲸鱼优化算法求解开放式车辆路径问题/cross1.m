%% ��һ�ֽ��淽ʽ
%����curInd��          ��ǰ�������
%����bestInd��         ȫ�����ž������
%����cusnum��          �˿���Ŀ
%����cap��             �������װ����
%����demands��         �˿�������
%����dist��            �������
%����belta��           Υ��װ����Լ���ĳͷ�����ϵ��
%���cur_ind��         ����λ�ú�ĵ�ǰ�������
function cur_ind=cross1(cur_ind,best_ind,cusnum,cap,demands,dist,belta)
N=numel(cur_ind);                %������峤��
sel_pos=[];                     %ѡ�����Ԫ�ؼ���
init_pos=randi([1,N],1,1);      %�ӵ�ǰ������������ѡ��һ��λ��
sel_pos=[sel_pos,init_pos];     %��init_pos��ӵ�sel_pos��
init_ele1=cur_ind(init_pos);     %��ǰ�������init_posλ���ϵ�Ԫ��
init_ele2=best_ind(init_pos);    %ȫ�����ž������init_posλ���ϵ�Ԫ��
next_ele2=init_ele2;            %��ʼ��ȫ�����ž����������һ����ѡ�е�Ԫ�ظ�ֵΪinit_ele2
if init_ele1~=init_ele2
    while init_ele1~=next_ele2
        cur_pos= find(cur_ind==next_ele2,1,'first');         %��ǰѡ�е�λ��
        next_ele2=best_ind(cur_pos);                         %ȫ�����ž������cur_posλ���ϵ�Ԫ��
        sel_pos=[sel_pos,cur_pos];                          %��cur_pos��ӵ�sel_pos��
    end
end
%% ���¾�������еĸ���Ԫ��
ind1=best_ind;                               %��ʼ�������ĵ�ǰ�������
ind2=cur_ind;                                %��ʼ��������ȫ�����ž������
ind1(sel_pos)=cur_ind(sel_pos);
ind2(sel_pos)=best_ind(sel_pos);
%% ���㽻����������������Ŀ�꺯��ֵ
obj1=obj_function(ind1,cusnum,cap,demands,dist,belta);
obj2=obj_function(ind2,cusnum,cap,demands,dist,belta);
%% ѡ��Ŀ�꺯��ֵ��С�ľ��������Ϊ��ǰ�������
if obj1<obj2
    cur_ind=ind1;
else
    cur_ind=ind2;
end
end