%% ����batches�����fbatches����batches�пյ�����ɾ��
%����batches��          ����������������ÿ�������������Ķ���
%���fbatches��         ɾ�������κ��batches
%���batches_num��      ����������Ŀ
function [fbatches,batches_num]=deal_batches(batches)
batches(cellfun(@isempty,batches))=[];  %ɾ��cell�����еĿ�Ԫ��
fbatches=batches;                       %��batches��ֵ��fbatches
batches_num=size(fbatches,1);           %ɾ����Ԫ������󣬶������������еĶ���������Ŀ
end