%% �ж�һ������·���Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������
%����route��       һ������·��
%����demands��     �˿�������
%����cap��         �������װ����
%���flagR��       ���һ��·���Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������
function flagR=JudgeRoute(route,demands,cap)
flagR=1;                        %��ʼ����װ����Լ��
Ld=leave_load(route,demands);   %�������·�����뿪��������ʱ��װ����
%���������װ����Լ������flagR��ֵΪ0
if Ld>cap
    flagR=0;
end
end