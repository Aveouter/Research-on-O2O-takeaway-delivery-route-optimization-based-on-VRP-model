%% 从visit所在的路径中移除包含visit在内的连续l个城市
%输入l：               要从该路径移除城市的数目
%输入visit：           从该路径移除的城市
%输入route：           visit所在的路径
%输入start：           起（终）点城市
%输出Rroute：          从当前路径中连续移除l个城市的集合
function Rroute=String(l,visit,route,start)
r_copy=route;                               %复制路径
r_copy(r_copy==start)=[];                   %将start从r_copy中删除
lr=numel(r_copy);                           %r_copy中城市数目
findv=find(r_copy==visit,1,'first');        %找出visit在r_copy中的位置
vLN=findv-1;                                %visit左侧的元素个数
vRN=lr-findv;                               %visit右侧的元素个数
%如果vLN小
if vLN<=vRN
    if vRN<l-1
        nR=floor(l-1-vLN+rand*(vRN-l+1+vLN));
        nL=l-1-nR;                          %visit左侧要移除元素的数目
    end
    if (vLN<=l-1)&&(vRN>=l-1)
        nR=floor(l-1-vLN+rand*(vLN));
        nL=l-1-nR;                          %visit左侧要移除元素的数目
    end
    if vLN>l-1
        nR=floor(rand*vLN);                 %visit右侧要移除元素的数目
        nL=l-1-nR;                          %visit左侧要移除元素的数目
    end
    r_copy=r_copy(findv-nL:findv+nR);       %随机删除包括visit在内的连续l个城市
end
%如果vRN小
if vLN>vRN
    if vLN<l-1
        nL=floor(l-1-vRN+rand*(vLN-l+1+vRN));
        nR=l-1-nL;                          %visit右侧要移除元素的数目
    end
    if (vRN<=l-1)&&(vLN>=l-1)
        nL=floor(l-1-vRN+rand*(vRN));
        nR=l-1-nL;                          %visit右侧要移除元素的数目
    end
    if vRN>l-1
        nL=floor(rand*vRN);                 %visit左侧要移除元素的数目
        nR=l-1-nL;                          %visit右侧要移除元素的数目
    end
    r_copy=r_copy(findv-nL:findv+nR);       %随机删除包括visit在内的连续l个城市
end
Rroute=r_copy;       
end