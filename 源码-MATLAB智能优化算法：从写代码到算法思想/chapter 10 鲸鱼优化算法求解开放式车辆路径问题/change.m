%% ���ͷ����뾨�����֮�����ת��
%����VC��          ���ͷ���
%����N��           ������峤��
%����cusnum��      �˿���Ŀ
%���individual��  �����ͷ���ת���ɵľ������
function individual=change(VC,N,cusnum)
NV=size(VC,1);                         %����ʹ����Ŀ
individual=[];
for i=1:NV
    if (cusnum+i)<=N
        individual=[individual,VC{i},cusnum+i];
    else
        individual=[individual,VC{i}];
    end
end
if length(individual)<N               %���������峤��С��N������Ҫ�����������������ı��
    supply=(cusnum+NV+1):N;
    individual=[individual,supply];
end
end