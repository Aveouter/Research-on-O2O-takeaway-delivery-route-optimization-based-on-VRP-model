%% 初始化灰狼种群
%输入NIND：            种群数目
%输入n：               城市数目
%输入m：               旅行商数目
%输入start：           起（终）点城市
%输出population：      灰狼种群
function population=init_pop(NIND,n,m,start)
len=n+m-1;                              %个体长度
population=zeros(NIND,len);             %初始化种群
for i=1:NIND
    population(i,:)=encode(n,m,start);
end
end