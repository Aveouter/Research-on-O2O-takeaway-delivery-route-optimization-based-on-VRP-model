%% swap操作后生成新的距离差矩阵Delta
%输入route：            一条路线
%输入dist：             距离矩阵
%输入i，j：             交换点i,j
%输出Delta1：           swap操作后的距离差值的矩阵
function Delta1=Update1(route,dist,i,j)
N=numel(route);                     %城市个数
route2=swap(route,i,j);             %交换route上i和j两个位置上的城市
Delta1=zeros(N,N);                  %N行N列的Delta初始化，每个位置上的元素是距离差值
for i=1:N-1
    for j=i+1:N
        Delta1(i,j)=cal_delta1(route2,dist,i,j);
    end
end