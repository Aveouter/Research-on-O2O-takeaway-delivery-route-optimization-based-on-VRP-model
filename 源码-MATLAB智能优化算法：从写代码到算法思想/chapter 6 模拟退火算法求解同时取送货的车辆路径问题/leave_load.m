%% 计算某一条路径上离开配送中心和各个顾客时的装载量
%输入route：       一条配送路线
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输出Ld：          货车离开配送中心时的装载量
%输出Lc：          货车离开各个顾客时的装载量
function [Ld,Lc]=leave_load(route,demands,pdemands)
n=length(route);                            %配送路线经过顾客的总数量
Ld=0;                                       %初始车辆在配送中心时的装货量为0
Lc=zeros(1,n);                              %表示车辆离开顾客时的装载量
if n~=0
    for i=1:n
        if route(i)~=0
            Ld=Ld+demands(route(i));
        end
    end
    Lc(1)=Ld+(pdemands(route(1))-demands(route(1)));
    if n>=2
        for j=2:n
            Lc(j)=Lc(j-1)+(pdemands(route(j))-demands(route(j)));
        end
    end
end
end