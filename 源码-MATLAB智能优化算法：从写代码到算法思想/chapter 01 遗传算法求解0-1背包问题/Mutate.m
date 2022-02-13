%% 变异操作
%输入SelCh：               被选择的个体
%输入Pm：                  变异概率
%输出SelCh：               变异后的个体
function SelCh=Mutate(SelCh,Pm)                     
[NSel,n]=size(SelCh);                               %n为染色体长度
for i=1:NSel
    if Pm>=rand
        R=randperm(n);                              %随机生成1~n的随机排列
        pos1=R(1);                                  %第1个变异位置
        pos2=R(2);                                  %第2个变异位置
        
        left=min([pos1,pos2]);                      %更小的那个值作为变异起点
        right=max([pos1,pos2]);                     %更大的那个值作为变异终点
        
        mutate_Selch=SelCh(i,:);                    %第i个进行变异操作的个体
        mutate_part=mutate_Selch(right:-1:left);    %进行变异操作后的变异片段
        mutate_Selch(left:right)=mutate_part;       %将mutate_Selch上的第left至right位上的片段进行替换
        
        SelCh(i,:)=mutate_Selch;                    %更新第i个进行变异操作的个体
    end
end