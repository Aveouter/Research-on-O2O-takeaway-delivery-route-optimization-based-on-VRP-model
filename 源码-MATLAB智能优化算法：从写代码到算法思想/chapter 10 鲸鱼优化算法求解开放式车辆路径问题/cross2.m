%% �ڶ��ֽ��淽ʽ
%����curInd��          ��ǰ�������
%����bestInd��         ȫ�����ž������
%����cusnum��          �˿���Ŀ
%����cap��             �������װ����
%����demands��         �˿�������
%����dist��            �������
%����belta��           Υ��װ����Լ���ĳͷ�����ϵ��
%���cur_ind��         ����λ�ú�ĵ�ǰ�������
function cur_ind=cross2(cur_ind,best_ind,cusnum,cap,demands,dist,belta)
N=numel(cur_ind);                    %������峤��
sel_num=randi([1,N],1,1);           %�ӵ�ǰ������������ѡ��Ԫ�ص���Ŀ
ran_seq=randperm(N);                %1~N���������

sel_pos1=ran_seq(1:sel_num);        %��ǰ��������б�ѡ�����λ�ü���
sel_pos1=sort(sel_pos1);            %��sel_pos1��������
sel_ele1=cur_ind(sel_pos1);          %��ǰ��������б�ѡ�����Ԫ�ؼ���

sel_pos2=zeros(1,sel_num);          %��ʼ��ȫ�����ž�������б�ѡ�����λ�ü���
for i=1:sel_num
    for j=1:N
        if sel_ele1(i)==best_ind(j)
            sel_pos2(i)=j;
        end
    end
end
sel_pos2=sort(sel_pos2);            %��sel_pos2��������
sel_ele2=best_ind(sel_pos2);         %ȫ�����ž�������б�ѡ�����Ԫ�ؼ���

%% ���¾�������еĸ���Ԫ��
ind1=cur_ind;                        %��ʼ�������ĵ�ǰ�������
ind2=best_ind;                       %��ʼ��������ȫ�����ž������
ind1(sel_pos1)=sel_ele2;
ind2(sel_pos2)=sel_ele1;
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