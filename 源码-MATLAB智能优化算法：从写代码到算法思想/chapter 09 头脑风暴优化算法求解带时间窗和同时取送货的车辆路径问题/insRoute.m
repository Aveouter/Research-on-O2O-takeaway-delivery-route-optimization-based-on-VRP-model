%% �ж��ܷ�һ���˿Ͳ��뵽һ��·���У�����ܣ��򽫸ù˿Ͳ��뵽���λ�ã���ʻ����������С��λ�ã�
%����visit         ������˿�
%����route��       һ������·��
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����cap��         �������װ����
%����a��           �˿�ʱ�䴰��ʼʱ��[a[i],b[i]]
%����b��           �˿�ʱ�䴰����ʱ��[a[i],b[i]]
%����L��           ��������ʱ�䴰����ʱ��
%����s��           �ͻ���ķ���ʱ��
%����dist��        �������
%����v��           ������ʻ�ٶ�
%���newRoute��    �������ɹ�����Ϊ��·�����������ʧ�ܣ���Ϊԭ·��
%���flag��        ����ܷ񽫵�ǰ�˿Ͳ��뵽��ǰ·���С�flag=1��ʾ�ܲ��룬flag=0��ʾ���ܲ���
%���deltaC��      ��������
function [newRoute,flag,deltaC]=insRoute(visit,route,demands,pdemands,cap,a,b,L,s,dist,v)
lr=numel(route);                            %��ǰ·���ϵĹ˿���Ŀ
%�Ƚ��˿Ͳ�ص�������С��λ��
rc0=[];                                     %��¼����˿ͺ����Լ����·��
delta0=[];                                  %��¼����˿ͺ������
for i=1:lr+1
    if i==lr+1
        rc=[route visit];
    elseif i==1
        rc=[visit route];
    else
        rc=[route(1:i-1) visit route(i:end)];
    end
    %% �ж�һ������·���ϵĸ������Ƿ�����װ����Լ����ʱ�䴰Լ����1��ʾ���㣬0��ʾ������
    flagR=JudgeRoute(rc,demands,pdemands,cap,a,b,s,L,dist,v);
    if flagR==1
        rc0=[rc0;rc];                                           %������·���洢��rc0������rc0��delta0��Ӧ
        dif=part_length(rc,dist)-part_length(route,dist);       %����ɱ�����
        delta0=[delta0;dif];                                    %���ɱ������洢��delta0
    end
end
%��������ں���·��
if isempty(rc0)
    flag=0;
    newRoute=route;
    deltaC=inf;
else %������ں���·��
    [deltaC,ind]=min(delta0);
    newRoute=rc0(ind,:);
    flag=1;
end
end