%% 重组操作
%输入Chrom：           父代种群
%输入SelCh：           子代种群
%输入fit：             父代适应度
%输出Chrom：           组合父代与子代后得到的新种群
function Chrom=reins(Chrom,SelCh,fit)
NIND=size(Chrom,1);
NSel=size(SelCh,1);
[~,index]=sort(fit,'descend');
Chrom=[Chrom(index(1:NIND-NSel),:);SelCh];
end