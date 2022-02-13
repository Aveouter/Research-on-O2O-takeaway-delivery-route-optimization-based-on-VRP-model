%% ����OVRP��ʼ��
%����cusnum��          �˿���Ŀ
%����demands��         �˿�������
%����cap��             �������װ����
%����dist��            �������
%���init_vc��         ��ʼ��
function init_vc=init(cusnum,demands,cap,dist)
%�Ƚ�����������Խ����ϵ�0��ֵΪ�����
for i=1:cusnum+1
    for j=1:cusnum+1
        if i==j
            dist(i,j)=inf;
        end
    end
end
k=1;                                    %ʹ�ó�����Ŀ����ʼ����Ϊ1
init_vc=cell(k,1);
visited=[];                             %��ʼ�����ʹ˿͵ļ���
unvisited=1:cusnum;                     %��ʼδ�����ʹ˿͵ļ���
% ��ʼ����
route=[];                               %�洢ÿ��·���ϵĹ˿�
load=0;                                 %��ʼ·�������������ĵ�װ����Ϊ0
while ~isempty(unvisited)
    %�����ǰ·�߷ǿ�
    if ~isempty(route)
        %�����ǰ·��Ϊ�գ����unvisited���ҳ���������������Ĺ˿�
        pre_dist=dist(route(end),:);    %��ǰ·��ĩβ�˿��������˿͵ľ���
        pre_dist(1)=inf;                %����ǰ·��ĩβ�˿�����������֮��ľ�����λ�����
        pre_dist(visited+1)=inf;        %����ǰ·��ĩβ�˿����Ѿ���ӽ����Ĺ˿�֮��ľ�����λ�����
        [~,pre_point]=min(pre_dist);    %�ҳ�pre_dist�е���Сֵ
        pre_point=pre_point-1;          %��Ϊ���������ڵ�һλ�����Թ˿������Ҫ��1
    else
        %�����ǰ·��Ϊ�գ����unvisited���ҳ���������������Ĺ˿�
        pre_dist=dist(1,:);             %���������������˿͵ľ���
        pre_dist(visited+1)=inf;        %��pre_point���Ѿ���ӽ����Ĺ˿�֮��ľ�����λ�����
        [~,pre_point]=min(pre_dist);    %�ҳ�pre_dist�е���Сֵ
        pre_point=pre_point-1;          %��Ϊ���������ڵ�һλ�����Թ˿������Ҫ��1
        unvisited(unvisited==pre_point)=[]; %��pre_point��unvisit��ɾ��
        visited=[visited,pre_point];        %��pre_point��ӵ�visit��
    end
    %���û�г�������Լ�����򽫹˿���ӵ���ǰ·��
    if load+demands(pre_point)<=cap
        load=load+demands(pre_point);       %��ʼ���������ĵ�װ��������
        unvisited(unvisited==pre_point)=[]; %��pre_point��unvisit��ɾ��
        visited=[visited,pre_point];        %��pre_point��ӵ�visit��
        route=[route,pre_point];            %���µ�ǰ·��
    else   %һ����������װ����Լ��������Ҫ����һ����
        %�ȴ�����һ�����������Ĺ˿�
        init_vc{k,1}=route;
        %Ȼ��route��գ�load����,k��1
        route=[];
        load=0;
        k=k+1;
    end
    %���������unvisited�����һ���˿ͣ������init_vc������������
    if isempty(unvisited)
        init_vc{k,1}=route;
        break
    end
end
end