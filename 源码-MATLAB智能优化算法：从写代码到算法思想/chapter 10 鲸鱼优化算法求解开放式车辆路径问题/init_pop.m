%% ��ʼ��������Ⱥ
%����NIND��                ��Ⱥ��Ŀ
%����N��                   ������峤��
%����cusnum��              �˿���Ŀ
%����init_vc��             ��ʼ���ͷ���
%���population��          ��ʼ������Ⱥ
function population=init_pop(NIND,N,cusnum,init_vc)
population=zeros(NIND,N);%���ڴ洢��Ⱥ
individual=change(init_vc,N,cusnum);
for j=1:NIND
    population(j,:)=individual;
end