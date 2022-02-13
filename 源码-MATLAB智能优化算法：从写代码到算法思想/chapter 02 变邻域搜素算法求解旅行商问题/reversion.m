%% 逆转操作
%有6个城市，当前解为123456，我们随机选择两个位置，然后将这两个位置之间的元素进行逆序排列。
%比如说，逆转2和5之间的所有元素，则逆转后的解为154326。
%输入route1：          路线1
%输入i,j：             逆转点i,j
%输出route2：          经过逆转结构变换后的路线2
function route2=reversion(route1,i,j)
i1=min([i,j]);
i2=max([i,j]);
route2=route1;
route2(i1:i2)=route1(i2:-1:i1);
end