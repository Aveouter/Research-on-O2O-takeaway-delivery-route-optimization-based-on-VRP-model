%% ���㵱ǰ���ͷ���Υ��װ����Լ��֮��
%����VC��          ���ͷ�������ÿ�����������Ĺ˿�
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����cap��         �������װ����
%���q��           ��������·��Υ��װ����Լ��֮��
function q=violateLoad(VC,demands,pdemands,cap)
NV=size(VC,1);                     %���ó�����Ŀ
q=0;
for i=1:NV
    route=VC{i};
    n=numel(route);
    [Ld,Lc]=leave_load(route,demands,pdemands);
    if Ld>cap
        q=q+Ld-cap;
    end
    for j=1:n
        if Lc(j)>cap
            q=q+Lc(j)-cap;
        end
    end
end
end