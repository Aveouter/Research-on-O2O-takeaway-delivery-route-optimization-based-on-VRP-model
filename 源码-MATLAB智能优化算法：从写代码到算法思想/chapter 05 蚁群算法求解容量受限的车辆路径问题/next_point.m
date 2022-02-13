%% 根据转移公式，找到蚂蚁k从i点出发移动到的下一个点j，j点必须是满足容量及时间约束且是未被蚂蚁k服务过的顾客
%输入k：                   蚂蚁序号
%输入Table：               路径记录表
%输入Tau：                 信息素矩阵
%输入Eta：                 启发函数，即距离矩阵的倒数
%输入alpha：               信息素重要程度因子
%输入beta：                启发函数重要程度因子
%输入dist：                距离矩阵
%输入cap：                 最大装载量
%输入demands：             需求量
%输出j：                   蚂蚁k从i点出发移动到的下一个点j
function j=next_point(k,Table,Tau,Eta,alpha,beta,dist,cap,demands)
route_k=Table(k,:);                                         %蚂蚁k的路径
i=route_k(find(route_k~=0,1,'last'));                       %蚂蚁k正在访问的顾客编号
if isempty(i)
    i=0;
end
route_k(route_k==0)=[];                                     %将0从蚂蚁k的路径记录数组中删除
cusnum=size(Table,2);                                       %顾客数目
allSet=1:cusnum;                                            %setxor(a,b)可以得到a,b两个矩阵不相同的元素，也叫不在交集中的元素，
unVisit=setxor(route_k,allSet);                             %找出蚂蚁k未服务的顾客集合
uvNum=length(unVisit);                                      %找出蚂蚁k未服务的顾客数目
VC=decode(route_k,cap,demands,dist);                        %蚂蚁k目前为止所构建出的所有路径
%如果当前路径配送方案为空
if ~isempty(VC)
    route=VC{end,1};                                            %蚂蚁k当前正在构建的路径
else
    %如果当前路径配送方案不为空
    route=[];
end
lr=length(route);                                           %蚂蚁k当前正在构建的路径所访问顾客数目
preroute=zeros(1,lr+1);                                     %临时变量，储存蚂蚁k当前正在构建的路径添加下一个点后的路径
preroute(1:lr)=route;
Nik=next_point_set(k,Table,cap,demands,dist);               %找到蚂蚁k从i点出发可以移动到的下一个点j的集合，j点必须是满足容量且是未被蚂蚁k服务过的顾客
%% 如果r>r0，依据概率公式用轮盘赌法选择点j
%如果Nik非空，即蚂蚁k可以在当前路径从顾客i继续访问顾客
if ~isempty(Nik)
    Nik_num=length(Nik);
    p_value=zeros(Nik_num,1);                           %记录状态转移概率
    for h=1:Nik_num
        j=Nik(h);
        p_value(h,1)=((Tau(i+1,j+1))^alpha)*((Eta(i+1,j+1))^beta);
    end
    p_value=p_value./sum(p_value);
    index=roulette(p_value);                            %根据轮盘赌选出序号
    j=Nik(index);                                       %确定顾客j
else
    %如果Nik为空，即蚂蚁k必须返回配送中心，从配送中心开始访问新的顾客
    p_value=zeros(uvNum,1);                             %记录状态转移概率
    for h=1:uvNum
        j=unVisit(h);
        p_value(h,1)=((Tau(i+1,j+1))^alpha)*((Eta(i+1,j+1))^beta);
    end
    p_value=p_value./sum(p_value);
    index=roulette(p_value);                            %根据轮盘赌选出序号
    j=unVisit(index);                                   %确定顾客j
end
end