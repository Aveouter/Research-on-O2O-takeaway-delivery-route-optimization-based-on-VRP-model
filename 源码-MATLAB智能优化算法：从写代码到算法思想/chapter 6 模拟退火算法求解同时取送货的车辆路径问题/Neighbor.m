%% ��ǰ�⾭�����������õ����½�
%����Scurr��       ��ǰ��
%����pSwap��       ѡ�񽻻��ṹ�ĸ���
%����pReversion��  ѡ����ת�ṹ�ĸ���
%����pInsertion��  ѡ�����ṹ�ĸ���
%���Snew��        �������������õ��ĵ��½�
function Snew=Neighbor(Scurr,pSwap,pReversion,pInsertion)
index=Roulette(pSwap,pReversion,pInsertion);
if index==1
    %�����ṹ
    Snew=Swap(Scurr);
elseif index==2
    %��ת�ṹ
    Snew=Reversion(Scurr);
else
    %����ṹ
    Snew=Insertion(Scurr);
end
end