%% �޸�����repair���ν�removed�еĳ��в��·����
%�ȼ���removed�и������в�ص�ǰ������������С������Ȼ���ٴ�����������С�����ĳ�����
%�ҳ�һ��(����������2С-����������1С)���ĳ��в�أ�����ִ�У�ֱ��ȫ�����
%����removed��                 ���Ƴ����еļ���
%����Sdestroy��                ���ƻ�����Ľ�
%����dist��                    �������
%���Srepair��                 ���޸�����Ľ�
%���repair_length��           Srepair���ܾ���
function [Srepair,repair_length]=repair(removed,Sdestroy,dist)
Srepair=Sdestroy;
%�������removed�еĳ��У�ֱ��ȫ�����в��
while ~isempty(removed)
    nr=numel(removed);                                  %�Ƴ������г�����Ŀ
    regret=zeros(nr,1);                                 %�洢removed�����в����á����·������ź�ֵ����
    %�������removed�еĳ��в�ص�ǰ���и�·����Ŀ�꺯��ֵ��
    for i=1:nr
        visit=removed(i);                               %��ǰҪ��صĳ���
        [~,up_delta]=ins_route(visit,dist,Srepair);     %��visit��ص�����ɱ���С��λ�ú��·�ߣ�ͬʱ����������뵽��������λ�õĲ���ɱ�
        de12=up_delta(2)-up_delta(1);                   %�����2С�ɱ��������1С�ɱ�������ֵ
        regret(i)=de12;                                 %���µ�ǰ���в����á����·������ź�ֵ
    end
    [~,max_index]=max(regret);                          %�ҳ��ź�ֵ���ĳ������
    reinsert_city=removed(max_index);                   %removed��׼����صĳ���
    Srepair=ins_route(reinsert_city,dist,Srepair);      %��reinsert_city��ص�Srepair
    removed(max_index)=[];                              %��removed(firIns)���д�removed���Ƴ�
end
repair_length=route_length(Srepair,dist);               %����Srepair���ܾ���
end