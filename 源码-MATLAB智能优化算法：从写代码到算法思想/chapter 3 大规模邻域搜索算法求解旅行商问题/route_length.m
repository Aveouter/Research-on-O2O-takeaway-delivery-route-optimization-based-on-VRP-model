%% 计算一条路线总距离
%输入route：            一条路线
%输入dist：             距离矩阵
%输出len：              该条路线总距离
function len=route_length(route,dist)
    N=numel(route);
    route=[route route(1)];
    len=0;
    for k=1:N 
        i=route(k);
        j=route(k+1); 
        len=len+dist(i,j); 
    end
end