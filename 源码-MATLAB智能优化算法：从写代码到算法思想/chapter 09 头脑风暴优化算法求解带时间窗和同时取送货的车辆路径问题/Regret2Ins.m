%% Regret2Ins ���ν�removed�еĹ˿Ͳ�����ͷ�����
%�ȼ���removed�и����˿Ͳ�ص�ǰ������������С����������Ȼ���ٴ�����������С���������Ĺ˿���
%�ҳ�һ��(����������2С-����������1С)���Ĺ˿Ͳ�أ�����ִ�У�ֱ��ȫ�����
%����removed��     ���Ƴ��˿͵ļ���
%rfvc��            �ƻ�������ͷ���
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����cap��         �������װ����
%����a��           �˿�ʱ�䴰��ʼʱ��[a[i],b[i]]
%����b��           �˿�ʱ�䴰����ʱ��[a[i],b[i]]
%����L��           ��������ʱ�䴰����ʱ��
%����s��           �ͻ���ķ���ʱ��
%����dist��        �������
%����v��           ������ʻ�ٶ�
%repFvc��          �޸�������ͷ���
function repFvc=Regret2Ins(removed,rfvc,demands,pdemands,cap,a,b,L,s,dist,v)
rfvcp=rfvc;             %���Ʋ��ֽ�
%�������removed�еĹ˿ͣ�ֱ��ȫ���˿Ͳ��
while ~isempty(removed)
    nr=length(removed);     %�Ƴ������й˿���Ŀ
    ri=zeros(nr,1);         %�洢removed���˿���á����·��
    rid=zeros(nr,1);        %�洢removed���˿Ͳ����á����·������ź�ֵ����
    NV=size(rfvcp,1);           %��ǰ�����ó�����Ŀ
    %�������removed�еĹ˿Ͳ�ص�ǰ���и�·����Ŀ�꺯��ֵ��
    for i=1:nr
        visit=removed(i);           %��ǰҪ��صĹ˿�
        dec=[];                     %��Ӧ��rc�ĳɱ���Լֵ
        ins=[];                     %��¼���Բ��·�������
        for j=1:NV
            route=rfvcp{j};          %��ǰ·��
            %% �ж��ܷ�һ���˿Ͳ��뵽һ��·���У�����ܣ��򽫸ù˿Ͳ��뵽���λ�ã�Ŀ�꺯��������С��λ�ã�
            [~,flag,deltaC]=insRoute(visit,route,demands,pdemands,cap,a,b,L,s,dist,v);
            %flag=1��ʾ�ܲ��룬flag=0��ʾ���ܲ���
            if flag==1
                dec=[dec;deltaC];
                ins=[ins;j];
            end
        end
        %������ڷ���Լ���Ĳ��·�������ҳ���¼�ź�ֵ�Լ���Ӧ��·��
        if ~isempty(ins)
            [sd,sdi]=sort(dec);                 %��dec��������
            insc=ins(sdi);                      %��ins�������dec��������Ŷ�Ӧ
            ri(i)=insc(1);                      %���µ�ǰ�˿���á����·��
            if size(ins)>1
                de12=sd(2)-sd(1);                   %�����2С�ɱ��������1С�ɱ�������ֵ
                rid(i)=de12;                        %���µ�ǰ�˿Ͳ����á����·������ź�ֵ
            else
                de12=sd(1);                   %�����2С�ɱ��������1С�ɱ�������ֵ
                rid(i)=de12;                        %���µ�ǰ�˿Ͳ����á����·������ź�ֵ
            end
        else    %��������ڷ���Լ����·�������½�·��
            temp=[visit];
            ri(i)=NV+1;
            rid(i)=part_length(temp,dist);
        end
    end
    %����rid  rid���Ĺ˿;����Ȳ�صĹ˿�
    [~,firIns]=max(rid);            %�ҳ��ź�ֵ���Ĺ˿����
    readyV=removed(firIns);          %removed��׼����صĹ˿�
    rIns=ri(firIns);                %���·�����
    %������·��Ϊ�½�·��
    if rIns==NV+1
        temp=readyV;
        %�½�·��������removed(firIns)�嵽��·����
        rfvcp{rIns,1}=temp;
        %��removed(firIns)�˿ʹ�removed���Ƴ�
        removed(firIns)=[];
    else
        %��firIns��ص�rIns
        rfvcp{rIns,1}=insRoute(removed(firIns),rfvcp{rIns,1},demands,pdemands,cap,a,b,L,s,dist,v);
        %��removed(firIns)�˿ʹ�removed���Ƴ�
        removed(firIns)=[];
    end
end
repFvc=rfvcp;
end