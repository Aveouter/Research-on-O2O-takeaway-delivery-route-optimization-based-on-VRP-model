%% ���㵥��Ⱦɫ���װ����Ʒ�ܼ�ֵ��������
%����n��                      ��Ʒ��Ŀ
%����Individual��             ����
%����p��                      ������Ʒ��ֵ
%����w��                      ������Ʒ����
%���sumP��                   �ø����װ����Ʒ�ܼ�ֵ
%���sumW��                   �ø����װ����Ʒ������
function [sumP,sumW]=Individual_P_W(n,Individual,p,w)
sumP=0;
sumW=0;
for i=1:n
    %���Ϊ1�����ʾ��Ʒ��װ��
    if Individual(i)==1
        sumP=sumP+p(i);
        sumW=sumW+w(i);  
    end
end
end