%% 计算某一条路径上离开配送中心时的装载量
%输入route：           当前配送路径
%输入demands：         顾客需求量
%输出Ld：              车辆离开配送中心时的装载量
function Ld=leave_load(route,demands)
n=length(route);       %配送路线经过顾客的数目
Ld=0;                  %初始车辆在配送中心时的装载量为0
if n~=0
    for i=1:n
        if route(i)~=0
            Ld=Ld+demands(route(i));
        end
    end
end
end