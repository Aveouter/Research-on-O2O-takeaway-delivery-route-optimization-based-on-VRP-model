%% insertion操作后生成新的距离差矩阵Delta
%输入route：            一条路线
%输入dist：             距离矩阵
%输入i，j：             插入点i,j
%输出Delta1：           insertion操作后的距离差值的矩阵
function Delta3=Update3(route,dist,i,j)
N=numel(route);                     %城市个数
route2=insertion(route,i,j);        %插入route上i和j两个位置上的城市
Delta3=zeros(N,N);                  %N行N列的Delta初始化，每个位置上的元素是距离差值
for i=1:N
    for j=1:N
        if i~=j
            Delta3(i,j)=cal_delta3(route2,dist,i,j);
        end
    end
end