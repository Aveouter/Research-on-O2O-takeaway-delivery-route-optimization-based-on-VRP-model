%% 计算一条配送路线的行驶距离
%输入route：           一条配送路线
%输入dist：            距离矩阵
%输出len：             该条配送路线的行驶距离
function len=part_length(route,dist)
n=numel(route);         %该条配送路线所经过的顾客数目
len=0;                  %行驶距离初始为0
if n~=0
    for i=1:n
        if i==1
            len=len+dist(1,route(i)+1);
        else
            len=len+dist(route(i-1)+1,route(i)+1);
        end
    end
end
end