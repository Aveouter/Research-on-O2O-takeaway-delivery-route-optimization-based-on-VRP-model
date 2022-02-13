%% ����ĳһ��·�����뿪�������ĺ͸����˿�ʱ��װ����
%����route��       һ������·��
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%���Ld��          �����뿪��������ʱ��װ����
%���Lc��          �����뿪�����˿�ʱ��װ����
function [Ld,Lc]=leave_load(route,demands,pdemands)
n=length(route);                            %����·�߾����˿͵�������
Ld=0;                                       %��ʼ��������������ʱ��װ����Ϊ0
Lc=zeros(1,n);                              %��ʾ�����뿪�˿�ʱ��װ����
if n~=0
    for i=1:n
        if route(i)~=0
            Ld=Ld+demands(route(i));
        end
    end
    Lc(1)=Ld+(pdemands(route(1))-demands(route(1)));
    if n>=2
        for j=2:n
            Lc(j)=Lc(j-1)+(pdemands(route(j))-demands(route(j)));
        end
    end
end
end