%% ��visit��ص�����ɱ���С��λ�ú��·�ߣ�ͬʱ����������뵽��������λ�õĲ���ɱ�
%����visit��               ������ĳ���
%����dist��                �������
%����route��               ������·��
%���new_route��           ��visit���뵽route��С����ɱ�λ�ú�Ľ�
%���up_delta��            ��visit���뵽route�и�������λ�ú�Ĳ���ɱ���С���������Ľ��
function [new_route,up_delta]=ins_route(visit,dist,route)
lr=numel(route);                            %��ǰ·�߳�����Ŀ
rc0=zeros(lr+1,lr+1);                       %��¼������к��·��
delta0=zeros(lr+1,1);                       %��¼������к������
for i=1:lr+1
    if i==lr+1
        rc=[route visit];
    elseif i==1
        rc=[visit route];
    else
        rc=[route(1:i-1) visit route(i:end)];
    end
    rc0(i,:)=rc;                                            %������·���洢��rc0������rc0��delta0��Ӧ
    dif=route_length(rc,dist)-route_length(route,dist);     %����ɱ�����
    delta0(i,1)=dif;                                        %���ɱ������洢��delta0
end
up_delta=sort(delta0);                                      %������ɱ���С��������
[~,ind]=min(delta0);                                        %������С����ɱ�����Ӧ�����
new_route=rc0(ind,:);                                        %��С����ɱ�����Ӧ�Ĳ�����·��
end