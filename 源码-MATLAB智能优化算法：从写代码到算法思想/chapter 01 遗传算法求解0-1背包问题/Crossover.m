%% 交叉操作
%输入SelCh：               被选择的个体
%输入Pc：                  交叉概率
%输出SelCh：               交叉后的个体
function SelCh=Crossover(SelCh,Pc)
[NSel,n]=size(SelCh);                               %n为染色体长度
for i=1:2:NSel-mod(NSel,2)
    if Pc>=rand %交叉概率Pc
        cross_pos=unidrnd(n);                       %随机生成一个1~N之间的交叉位置
        
        cross_Selch1=SelCh(i,:);                    %第i个进行交叉操作的个体
        cross_Selch2=SelCh(i+1,:);                  %第i+1个进行交叉操作的个体
        
        cross_part1=cross_Selch1(1:cross_pos);      %第i个进行交叉操作个体的交叉片段
        cross_part2=cross_Selch2(1:cross_pos);      %第i+1个进行交叉操作个体的交叉片段
        
        cross_Selch1(1:cross_pos)=cross_part2;      %用第i+1个个体的交叉片段替换掉第i个个体交叉片段
        cross_Selch2(1:cross_pos)=cross_part1;      %用第i个个体的交叉片段替换掉第i+1个个体交叉片段
        
        SelCh(i,:)=cross_Selch1;                    %更新第i个个体
        SelCh(i+1,:)=cross_Selch2;                  %更新第i+1个个体
    end
end