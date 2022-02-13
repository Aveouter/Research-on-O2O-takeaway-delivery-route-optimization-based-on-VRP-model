%% 将给定的route序列在i和j位置之间进行逆序排列，然后计算转换序列前和转换序列后的路径距离的差值
%输入route：            一条路线
%输入dist：             距离矩阵
%输入i，j：             逆转点i,j
%输出delta2：           reversion后路线的总距离-reversion前路线的总距离
function delta2=cal_delta2(route,dist,i,j)
N=numel(route);                 %城市个数
if i==1
    if j==N
        delta2=0;
    else
        delta2=-dist(route(j),route(j+1))-dist(route(N),route(i))+...
            dist(route(i),route(j+1))+dist(route(N),route(j));
    end
else
    if j==N
        delta2=-dist(route(i-1),route(i))-dist(route(1),route(j))+...
            dist(route(i-1),route(j))+dist(route(i),route(1));
    else
        delta2=-dist(route(i-1),route(i))-dist(route(j),route(j+1))+...
            dist(route(i-1),route(j))+dist(route(i),route(j+1));
    end
end
end