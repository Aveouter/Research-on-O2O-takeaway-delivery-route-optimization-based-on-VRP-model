%% ��ָ���Ĺ˿ͼ��ϴӵ�ǰ���Ƴ�
%����removed��         ���Ƴ��Ĺ˿ͼ���
%����VC��              ���ͷ���
%���rfvc��            ��removed�е����й˿ʹ�VC���Ƴ���Ľ�
function rfvc=remove_customer(removed,VC)
rfvc=VC;                            %�Ƴ�removed�еĹ˿ͺ��VC
nre=numel(removed);                 %���ձ��Ƴ��˿͵�������
NV=size(VC,1);                      %���ó�����
for i=1:NV
    route=VC{i};
    for j=1:nre
        findri=find(route==removed(j),1,'first');
        if ~isempty(findri)
            route(route==removed(j))=[];
        end
    end
    rfvc{i}=route;
end
[rfvc,~]=deal_vehicles_customer(rfvc);
end