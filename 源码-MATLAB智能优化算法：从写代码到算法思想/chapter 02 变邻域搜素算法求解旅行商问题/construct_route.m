%% ̰���㷨����TSP�ĳ�ʼ��
%����dist��             �������   
%���init_route��      ̰���㷨����ĳ�ʼ·��
%���init_len��        init_route���ܾ���  
function [init_route,init_len]=construct_route(dist)
N=size(dist,1);                     %������Ŀ
%�Ƚ�����������Խ����ϵ�0��ֵΪ�����
for i=1:N
    for j=1:N
        if i==j
            dist(i,j)=inf;
        end
    end
end

unvisited=1:N;                      %��ʼδ�����ŵĳ��м���
visited=[];                         %��ʼ�ѱ����ŵĳ��м���

min_dist=min(min(dist));            %�ҳ���������е���Сֵ
[row,col]=find(dist==min_dist);     %��dist���ҳ�min_dist����Ӧ���к���
first=row(1);                       %��min_dist��dist������Ӧ�������Ϊ���

unvisited(unvisited==first)=[];     %��first��unvisit��ɾ��
visited=[visited,first];            %��first��ӵ�visit��
pre_point=first;                    %��fisrt��ֵ��pre_point
while ~isempty(unvisited)
    pre_dist=dist(pre_point,:);     %pre_point���������еľ���
    pre_dist(visited)=inf;          %��pre_point���Ѿ���ӽ����ĳ���֮��ľ�����λ�����
    [~,pre_point]=min(pre_dist);    %�ҳ�pre_dist�е���Сֵ
    unvisited(unvisited==pre_point)=[]; %��pre_point��unvisit��ɾ��
    visited=[visited,pre_point];        %��pre_point��ӵ�visit��
end
init_route=visited;
init_len=route_length(init_route,dist); %����init_route���ܾ���
end