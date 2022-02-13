%% 交叉操作
%输入SelCh：       被选中的子代种群
%输入Pc：          交叉概率
%输出SelCh：       交叉后的子代种群
function SelCh=crossover(SelCh,Pc)
NSel=size(SelCh,1);
for i=1:2:NSel-mod(NSel,2)
    if Pc>=rand %交叉概率Pc
        [SelCh(i,:),SelCh(i+1,:)]=cross_operator(SelCh(i,:),SelCh(i+1,:));
    end
end
end