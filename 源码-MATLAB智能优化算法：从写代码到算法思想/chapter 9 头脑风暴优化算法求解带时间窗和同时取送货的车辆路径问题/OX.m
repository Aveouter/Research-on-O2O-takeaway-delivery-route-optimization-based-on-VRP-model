%% 交叉操作
%输入Individual1：  个体1
%输入Individual2：  个体2
%输出Individual1：  交叉后的个体1
%输出Individual2：  交叉后的个体2
function [Individual1,Individual2]=OX(Individual1,Individual2)
L=length(Individual1);
while 1
    r1=randsrc(1,1,[1:L]);
    r2=randsrc(1,1,[1:L]);
    if r1~=r2
        s=min([r1,r2]);
        e=max([r1,r2]);
        a0=[Individual2(s:e),Individual1];
        b0=[Individual1(s:e),Individual2];
        for i=1:length(a0)
            aindex=find(a0==a0(i));
            bindex=find(b0==b0(i));
            if length(aindex)>1
                a0(aindex(2))=[];
            end
            if length(bindex)>1
                b0(bindex(2))=[];
            end
            if i==length(Individual1)
                break
            end
        end
        Individual1=a0;
        Individual2=b0;
        break
    end
end