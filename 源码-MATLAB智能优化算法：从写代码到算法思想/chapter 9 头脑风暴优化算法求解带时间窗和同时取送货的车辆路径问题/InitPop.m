%% ��Ⱥ��ʼ��
%����NIND��        ��Ⱥ��С
%����N��           ���峤��
%���Population��  ������ɵĳ�ʼ��Ⱥ
function Population=InitPop(NIND,N)
Population=zeros(NIND,N);                %��Ⱥ��ʼ��ΪNIND��N�е������
for i=1:NIND
    Population(i,:)=randperm(N);         %ÿ������Ϊ1~N���������
end
end