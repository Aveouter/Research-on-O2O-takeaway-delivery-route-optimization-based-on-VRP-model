%% ������S��·�������һ���ζ����������߾���
%����batch��               һ���ζ���
%����orders��              ÿ����������������Ʒ��Ϣ
%����side_num��            ÿ����ѡͨ��һ��Ĵ�λ��Ŀ
%����depot_leftAisle��     �ֿ����1����ѡͨ���ľ��룬1.5LU
%����enter_leave_aisle��   ������ͨ�������ѡͨ����Ӽ�ѡͨ����������ͨ����Ҫ���ߵľ��룬1LU
%����adjacent_location��   ͬһ����ѡͨ�����������ڴ�λ֮��ľ��룬1LU
%����adjacent_aisle��      �������ڼ�ѡͨ���ľ��룬5LUs
%���s_len��               ����S�μ�ѡ·�����Լ�ѡ���������������ߵľ���
function s_len=shpath(batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
%% ����������ת��Ϊ�������Ĵ�λ
locs=batch_to_location(batch,orders);
%% ������������л��������ͨ�����
aisle_no=ceil(locs/(2*side_num));
%% �������ͨ�����
max_No=max(aisle_no);
%% �ҳ������һ������ͨ���Ļ�����
index= aisle_no==max_No;
loc_final=locs(index);
%% �ҳ�loc_final������������Ĵ�λ���
right_len=rem(loc_final,side_num);
for j=1:numel(right_len)
    if right_len(1,j)==0 
        right_len(1,j)=side_num;
    end
end
[~,max_index]=max(right_len);
maxLoc=right_len(max_index);
%% ɾ���ظ�����ͨ��
aisle_no=unique(aisle_no);
%% ��������������ͨ��������
long_num=numel(aisle_no);
%% �������г�ʼ������������
if rem(long_num,2)==0
    long_len=long_num*((side_num-1)*adjacent_location+enter_leave_aisle*2);
else
    long_len1=(long_num-1)*((side_num-1)*adjacent_location+enter_leave_aisle*2);
    a=rem(maxLoc,side_num);
    if(a==0)
        long_len2=2*((side_num-1)*adjacent_location+enter_leave_aisle);
    else 
        long_len2=2*((a-1)*adjacent_location+enter_leave_aisle);
    end
    long_len=long_len1+long_len2;
end
%% �����ܵĺ������
cross_len=(max_No-1)*adjacent_aisle*2+depot_leftAisle*2;
%% �ܾ���
s_len=long_len+cross_len;
end