%% 破坏函数destroy根据从当前解中连续移除若干个城市
%输入route：                   当前解，一条路线
%输出Sdestroy：                移除removed中的城市后的route
%输出removed：                 被移除的城市集合
function [Sdestroy,removed]=destroy(route)
N=numel(route);                                 %当前解中城市数目
Lmin=1;                                         %一条路径中所允许移除最小的城市数目
Lmax=min(ceil(N/2),25);                         %一条路径中所允许移除最大的城市数目
visit=ceil(rand*N);                             %从当前解中随机选出要被移除的城市
L=Lmin+ceil((Lmax-Lmin)*rand);                  %计算在该条路径上移除的城市的数目

findv=find(route==visit,1,'first');             %找出visit在route中的位置
vLN=findv-1;                                    %visit左侧的城市个数
vRN=N-findv;                                    %visit右侧的城市个数
%如果vLN小
if vLN<=vRN
    if (vRN<L-1)&&(vLN<L-1)
        nR=L-1-vLN+round(rand*(vRN-L+1+vLN));
        nL=L-1-nR;                              %visit左侧要移除城市的数目
    elseif (vRN>L-1)&&(vLN>L-1)
        nR=round(rand*vLN);                     %visit右侧要移除城市的数目
        nL=L-1-nR;                              %visit左侧要移除城市的数目
    else
        nR=L-1-vLN+round(rand*vLN);
        nL=L-1-nR;                              %visit左侧要移除城市的数目
    end
else
    %如果vRN小
    if (vLN<L-1)&&(vRN<L-1)
        nL=L-1-vRN+round(rand*(vLN-L+1+vRN));
        nR=L-1-nL;                              %visit右侧要移除城市的数目
    elseif (vLN>L-1)&&(vRN>L-1)
        nL=round(rand*vRN);                     %visit左侧要移除城市的数目
        nR=L-1-nL;                              %visit右侧要移除城市的数目
    else
        nL=L-1-vRN+round(rand*vRN);
        nR=L-1-nL;                              %visit右侧要移除城市的数目
    end
end
removed=route(findv-nL:findv+nR);               %移除城市的集合，即包括visit在内的连续L个城市

Sdestroy=route;                                 %复制route
for i=1:L
    Sdestroy(Sdestroy==removed(i))=[];          %将removed中的所有城市从route中移除
end
end