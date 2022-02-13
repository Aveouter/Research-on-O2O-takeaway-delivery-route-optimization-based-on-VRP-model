%% reversion操作后生成新的距离差矩阵Delta
%输入route：            一条路线
%输入dist：             距离矩阵
%输入i，j：             逆转点i,j
%输出Delta2：           reversion操作后的距离差值的矩阵
function Delta2=Update2(route,dist,i,j)
N=numel(route);                     %城市个数
route2=reversion(route,i,j);        %逆转route上i和j两个位置上的城市
Delta2=zeros(N,N);                  %N行N列的Delta初始化，每个位置上的元素是距离差值
for i=1:N-1
    for j=i+1:N
        Delta2(i,j)=cal_delta2(route2,dist,i,j);
    end
end