%% 根据城市数目、旅行商数目以及起（终）点城市编码出灰狼个体
%输入n：               城市数目
%输入m：               旅行商数目
%输入start：           起（终）点城市
%输出individual：      灰狼个体
function individual=encode(n,m,start)
%% 生成灰狼个体的第一部分
part1=randperm(n);                              %对城市进行随机排序
part1(part1==start)=[];                         %将起（终）点城市从part1中删除
%% 生成灰狼个体的第二部分
part2=zeros(1,m);                               %初始化每个旅行商访问城市数目（不包括start）
if m==1
    part2=n-1;
else
    for i=1:m
        if i==1
            right=n-1-(m-1);                        %最大取值
            part2(i)=randi([1,right],1,1);
        elseif i==m
            part2(i)=n-1-sum(part2(1:(i-1)));
        else
            right=n-1-(m-i)-sum(part2(1:(i-1)));    %最大取值
            part2(i)=randi([1,right],1,1);
        end
    end
end
%% 将两部分进行合并，生成最终灰狼个体
individual=[part1,part2];                       %将两段合并
end