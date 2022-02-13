%% 初始化鲸鱼种群
%输入NIND：                种群数目
%输入N：                   鲸鱼个体长度
%输入cusnum：              顾客数目
%输入init_vc：             初始配送方案
%输出population：          初始鲸鱼种群
function population=init_pop(NIND,N,cusnum,init_vc)
population=zeros(NIND,N);%用于存储种群
individual=change(init_vc,N,cusnum);
for j=1:NIND
    population(j,:)=individual;
end