%% ����һ������·�ߵ���ʻ����
%����route��           һ������·��
%����dist��            �������
%���len��             ��������·�ߵ���ʻ����
function len=part_length(route,dist)
n=numel(route);         %��������·���������Ĺ˿���Ŀ
len=0;                  %��ʻ�����ʼΪ0
if n~=0
    for i=1:n
        if i==1
            len=len+dist(1,route(i)+1);
        else
            len=len+dist(route(i-1)+1,route(i)+1);
        end
    end
end
end