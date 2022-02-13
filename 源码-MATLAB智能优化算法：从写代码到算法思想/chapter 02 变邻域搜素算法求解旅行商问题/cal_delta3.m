%% 计算insertion操作后与操作前路线route的总距离的差值
%输入route：            一条路线
%输入dist：             距离矩阵
%输入i，j：             逆转点i,j
%输出delta1：           insertion后路线的总距离-insertion前路线的总距离
function delta3=cal_delta3(route,dist,i,j)
N=numel(route);         %城市数目
if i<j
    if (i==1) && (j==N)
        delta3=0;
    elseif (i==1) && (j==2)
        delta3=-(dist(route(N),route(i))+dist(route(j),route(j+1)))+...
            (dist(route(N),route(j))+dist(route(i),route(j+1)));
    elseif i==1
        delta3=-(dist(route(N),route(i))+dist(route(i),route(i+1))+dist(route(j),route(j+1)))+...
            (dist(route(N),route(i+1))+dist(route(j),route(i))+dist(route(i),route(j+1)));
    elseif (i==N-1)&&(j==N)
        delta3=-(dist(route(i-1),route(i))+dist(route(j),route(1)))+...
            (dist(route(i-1),route(j))+dist(route(i),route(1)));
    elseif j==N
        delta3=-(dist(route(i-1),route(i))+dist(route(i),route(i+1))+dist(route(j),route(1)))+...
            (dist(route(i-1),route(i+1))+dist(route(j),route(i))+dist(route(i),route(1)));
    elseif (j-i)==1
        delta3=-(dist(route(i-1),route(i))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(j))+dist(route(i),route(j+1)));
    else
        delta3=-(dist(route(i-1),route(i))+dist(route(i),route(i+1))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(i+1))+dist(route(j),route(i))+dist(route(i),route(j+1)));
    end
else
    if (i==N) && (j==1)
        delta3=-(dist(route(i-1),route(i))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(j))+dist(route(i),route(j+1)));
    elseif (i-j)==1
        delta3=0;
    elseif i==N
        delta3=-(dist(route(i-1),route(i))+dist(route(i),route(1))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(1))+dist(route(j),route(i))+dist(route(i),route(j+1)));
    else
        delta3=-(dist(route(i-1),route(i))+dist(route(i),route(i+1))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(i+1))+dist(route(j),route(i))+dist(route(i),route(j+1)));
    end
end
end