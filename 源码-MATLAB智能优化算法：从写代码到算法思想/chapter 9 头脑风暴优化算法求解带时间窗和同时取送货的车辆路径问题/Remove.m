%% Remove�������ȴ�ԭ�й˿ͼ��������ѡ��һ���˿ͣ�Ȼ�����������������Ƴ���Ҫ��Ŀ�Ĺ˿�
%����cusnum��      �˿���Ŀ
%����toRemove��    ��Ҫ�Ƴ��˿͵���Ŀ
%����D��           ���Ԫ��
%����dist��        �������
%����VC��          ���ͷ�������ÿ�����������Ĺ˿�
%removed��         ���Ƴ��Ĺ˿ͼ���
%rfvc��            �Ƴ�removed�еĹ˿ͺ��VC
function [removed,rfvc]=Remove(cusnum,toRemove,D,dist,VC)
%% Remove
inplan=1:cusnum;            %���й˿͵ļ���
visit=ceil(rand*cusnum);    %��������й˿������ѡ��һ���˿�
inplan(inplan==visit)=[];   %�����Ƴ��Ĺ˿ʹ�ԭ�й˿ͼ������Ƴ�
removed=[visit];            %���Ƴ��Ĺ˿ͼ���
while length(removed)<toRemove
    nr=length(removed);             %��ǰ���Ƴ��Ĺ˿���Ŀ
    vr=ceil(rand*nr);               %�ӱ��Ƴ��Ĺ˿ͼ��������ѡ��һ���˿�
    nip=length(inplan);             %ԭ���˿ͼ����й˿͵���Ŀ
    R=zeros(1,nip);                 %�洢removed(vr)��inplan��ÿ��Ԫ�ص�����Ե�����
    for i=1:nip
        R(i)=Relatedness(removed(vr),inplan(i),dist,VC);   %����removed(vr)��inplan��ÿ��Ԫ�ص������
    end
    [SRV,SRI]=sort(R,'descend');        
    lst=inplan(SRI);                %��inplan�е����鰴removed(vr)���������ԴӸߵ�������
    vc=lst(ceil(rand^D*nip));       %��lst������ѡ��һ���ͻ�
    removed=[removed vc];           %���Ƴ��Ĺ˿ͼ�������ӱ��Ƴ��Ĺ˿�
    inplan(inplan==vc)=[];          %�����Ƴ��Ĺ˿ʹ�ԭ�й˿ͼ������Ƴ�
end
rfvc=remove_customer(removed,VC);   %��removed�е����й˿ʹ�VC���Ƴ���Ľ�
end