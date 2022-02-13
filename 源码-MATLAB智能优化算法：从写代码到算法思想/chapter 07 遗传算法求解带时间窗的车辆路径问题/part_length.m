%% 计算一条配送路线的行驶距离
%输入route：           当前配送路径
%输入dist：            距离矩阵
%输出p_l：             当前配送路线行驶距离
function p_l=part_length(route,dist)
n=length(route);
p_l=0;
if n~=0
    for i=1:n
        %因为配送中心在dist矩阵中的第一行（列），所以在计算两个节点距离时需要将坐标加1
        if i==1
            p_l=p_l+dist(1,route(i)+1);
        else
            p_l=p_l+dist(route(i-1)+1,route(i)+1);
        end
    end
    p_l=p_l+dist(route(end)+1,1);
end
end