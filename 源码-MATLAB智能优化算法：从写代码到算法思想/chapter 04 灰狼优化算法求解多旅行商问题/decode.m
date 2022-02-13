%% 对灰狼个体进行解码，解码为旅行商行走路线方案
%输入individual：      灰狼个体
%输入n：               城市数目
%输入m：               旅行商数目
%输入start：           起（终）点城市
%输出RP：              旅行商行走路线方案
function RP=decode(individual,n,m,start)
RP=cell(m,1);                       %初始化m条行走路线
part1=individual(1:n-1);            %提取城市排序序列
part2=individual(n:(n+m-1));        %提取各个旅行商所访问城市的数目
for i=1:m
    if i==1
        left=1;                     %在part1中，第i个旅行商访问城市的序号，即从start出发前往的下一个城市在part1中的序号
        right=part2(i);             %在part1中，第i个旅行商访问城市的序号，即返回至start的前一个城市在part1中的序号
        route=[start,part1(left:right),start];  %将start添加到这条路线的首末位置
    else
        left=sum(part2(1:(i-1)))+1; %在part1中，第i个旅行商访问城市的序号，即从start出发前往的下一个城市在part1中的序号
        right=sum(part2(1:i));      %在part1中，第i个旅行商访问城市的序号，即返回至start的前一个城市在part1中的序号
        route=[start,part1(left:right),start];  %将start添加到这条路线的首末位置
    end
    RP{i,1}=route;
end
end