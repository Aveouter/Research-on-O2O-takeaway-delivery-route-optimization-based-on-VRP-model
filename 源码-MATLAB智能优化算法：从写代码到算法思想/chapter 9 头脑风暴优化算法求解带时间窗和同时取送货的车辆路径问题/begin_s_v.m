%% ����ÿ��������·�����ڸ����㿪ʼ�����ʱ�䣬�����㷵����������ʱ��
%����VC��          ���ͷ���
%����a��           �˿���ʱ�䴰
%����s��           �Թ˿͵ķ���ʱ��
%����dist��        �������
%����v��           ������ʻ�ٶ�
%���bsv��         ÿ����������������·�����ڸ����˿Ϳ�ʼ�����ʱ���Լ�������������ʱ��
function bsv=begin_s_v(VC,a,s,dist,v)
n=size(VC,1);
bsv=cell(n,1);
for i=1:n
    route=VC{i};
    [bs,back]= begin_s(route,a,s,dist,v);
    bsv{i}=[bs,back];
end
end