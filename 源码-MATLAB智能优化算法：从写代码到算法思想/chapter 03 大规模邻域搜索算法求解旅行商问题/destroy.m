%% �ƻ�����destroy���ݴӵ�ǰ���������Ƴ����ɸ�����
%����route��                   ��ǰ�⣬һ��·��
%���Sdestroy��                �Ƴ�removed�еĳ��к��route
%���removed��                 ���Ƴ��ĳ��м���
function [Sdestroy,removed]=destroy(route)
N=numel(route);                                 %��ǰ���г�����Ŀ
Lmin=1;                                         %һ��·�����������Ƴ���С�ĳ�����Ŀ
Lmax=min(ceil(N/2),25);                         %һ��·�����������Ƴ����ĳ�����Ŀ
visit=ceil(rand*N);                             %�ӵ�ǰ�������ѡ��Ҫ���Ƴ��ĳ���
L=Lmin+ceil((Lmax-Lmin)*rand);                  %�����ڸ���·�����Ƴ��ĳ��е���Ŀ

findv=find(route==visit,1,'first');             %�ҳ�visit��route�е�λ��
vLN=findv-1;                                    %visit���ĳ��и���
vRN=N-findv;                                    %visit�Ҳ�ĳ��и���
%���vLNС
if vLN<=vRN
    if (vRN<L-1)&&(vLN<L-1)
        nR=L-1-vLN+round(rand*(vRN-L+1+vLN));
        nL=L-1-nR;                              %visit���Ҫ�Ƴ����е���Ŀ
    elseif (vRN>L-1)&&(vLN>L-1)
        nR=round(rand*vLN);                     %visit�Ҳ�Ҫ�Ƴ����е���Ŀ
        nL=L-1-nR;                              %visit���Ҫ�Ƴ����е���Ŀ
    else
        nR=L-1-vLN+round(rand*vLN);
        nL=L-1-nR;                              %visit���Ҫ�Ƴ����е���Ŀ
    end
else
    %���vRNС
    if (vLN<L-1)&&(vRN<L-1)
        nL=L-1-vRN+round(rand*(vLN-L+1+vRN));
        nR=L-1-nL;                              %visit�Ҳ�Ҫ�Ƴ����е���Ŀ
    elseif (vLN>L-1)&&(vRN>L-1)
        nL=round(rand*vRN);                     %visit���Ҫ�Ƴ����е���Ŀ
        nR=L-1-nL;                              %visit�Ҳ�Ҫ�Ƴ����е���Ŀ
    else
        nL=L-1-vRN+round(rand*vRN);
        nR=L-1-nL;                              %visit�Ҳ�Ҫ�Ƴ����е���Ŀ
    end
end
removed=route(findv-nL:findv+nR);               %�Ƴ����еļ��ϣ�������visit���ڵ�����L������

Sdestroy=route;                                 %����route
for i=1:L
    Sdestroy(Sdestroy==removed(i))=[];          %��removed�е����г��д�route���Ƴ�
end
end