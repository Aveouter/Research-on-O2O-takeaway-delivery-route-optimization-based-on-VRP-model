%% ���Ƴ������еĶ����ӵ�ǰ���������������Ƴ�
%����removed��         �����Ƴ��Ķ���
%����batches��         ��ǰ������������
%���r_batches��       �Ƴ���Ķ�����������
function r_batches=dealRemove(removed,batches)
r_batches=batches;              %��ʼ��batches��ֵ��r_batches
H=size(batches,1);              %��ǰ�������������ж���������Ŀ
for i=1:H
    batch=batches{i};           %��i���ζ���
    findri=find(batch==removed,1,'first');  %Ѱ��removed��batch�е�λ�ã������ڷ��ؿ�
    %����ڵ�i���ζ������ҵ����Ƴ��Ķ���removed�������batch���Ƴ���Ȼ������ѭ��
    if ~isempty(findri)
        batch(batch==removed)=[];   %��removed��batch���Ƴ�
        r_batches{i}=batch;         %����r_batches�еĵ�i���ζ���
        break;          
    end 
end
r_batches=deal_batches(r_batches);
end