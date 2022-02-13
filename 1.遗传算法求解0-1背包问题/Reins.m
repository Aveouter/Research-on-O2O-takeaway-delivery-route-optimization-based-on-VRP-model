%% 重插入子代的新种群
%输入Chrom：               父代种群
%输入SelCh：               子代种群
%输入Obj：                 父代适应度
%输出Chrom：               重组后得到的新种群
function Chrom=Reins(Chrom,SelCh,Obj)
NIND=size(Chrom,1);
NSel=size(SelCh,1);
[~,index]=sort(Obj,'descend');
Chrom=[Chrom(index(1:NIND-NSel),:);SelCh];