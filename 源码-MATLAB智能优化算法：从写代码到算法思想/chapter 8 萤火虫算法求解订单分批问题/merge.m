%% �����²�����õ�����Ⱥ��ֲ�����������õ�����Ⱥ���кϲ�
%����Population��      ���²�����õ�����Ⱥ
%����offspring��       �ֲ�����������õ�����Ⱥ
%����Obj��             ���²�����õ�����Ⱥ��Ŀ�꺯��ֵ
%���Population��      �ϲ�������Ⱥ��õ�������Ⱥ
function Population=merge(Population,offspring,Obj)
NIND=size(Population,1);
NSel=size(offspring,1);
[~,index]=sort(Obj);
Population=[Population(index(1:NIND-NSel),:);offspring];
end