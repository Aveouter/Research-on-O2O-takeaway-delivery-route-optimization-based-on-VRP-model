%% 交换操作
%比如说有6个城市，当前解为123456，随机选择两个位置，然后将这两个位置上的元素进行交换。
%比如说，交换2和5两个位置上的元素，则交换后的解为153426。
%输入route1：          路线1
%输入i,j：             两个交换点
%输出route2：          经过交换操作变换后的路线2
function route2=swap(route1,i,j)
route2=route1;
route2([i j])=route1([j i]);
end