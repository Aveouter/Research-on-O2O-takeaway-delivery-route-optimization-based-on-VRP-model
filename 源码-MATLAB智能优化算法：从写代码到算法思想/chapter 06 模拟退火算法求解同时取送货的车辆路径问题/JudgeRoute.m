%% �ж�һ������·���ϵĸ������Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������
%����route��       һ������·��
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����cap��         �������װ����
%���flagR��       ���һ������·���Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������
function flagR=JudgeRoute(route,demands,pdemands,cap)
flagR=0;                                        %��ʼ������װ����Լ��
[Ld,Lc]=leave_load(route,demands,pdemands);     %�������·�����뿪�������ĺ͸����˿�ʱ��װ����
overload_flag=find(Lc>cap,1,'first');           %��ѯ�Ƿ���ڳ������뿪ĳ���˿�ʱΥ��װ����Լ��
%���ÿ���㶼����װ����Լ������flagR��ֵΪ1
if (Ld<=cap)&&(isempty(overload_flag))
    flagR=1;
end
end