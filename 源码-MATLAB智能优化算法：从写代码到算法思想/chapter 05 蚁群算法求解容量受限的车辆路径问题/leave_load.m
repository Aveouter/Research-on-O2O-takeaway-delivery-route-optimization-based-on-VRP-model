%% ����ĳһ��·�����뿪�������ĺ͹˿�ʱ��װ����
%����route��               һ������·��
%����demands��             �˿�������
%���Ld��                  �����뿪��������ʱ��װ����
function Ld=leave_load(route,demands)
n=numel(route);                             %����·�߾����˿͵�����Ŀ
Ld=0;                                       %��ʼ��������������ʱ��װ����Ϊ0
if n~=0
    for i=1:n
        if route(i)~=0
            Ld=Ld+demands(route(i));
        end
    end
end
end