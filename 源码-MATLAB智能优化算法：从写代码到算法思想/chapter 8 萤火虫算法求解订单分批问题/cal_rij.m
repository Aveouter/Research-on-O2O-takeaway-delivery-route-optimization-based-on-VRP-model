%% 计算两个萤火虫个体之间的距离，距离定义为对应位置上不同元素的数目之和
%如果相对于位置上的元素相同，则为1，否则为0。
%输入firefly1：         萤火虫个体1
%输入firefly2：         萤火虫个体2
%输出rij：              萤火虫个体1与萤火虫个体2之间的距离
function rij=cal_rij(firefly1,firefly2)
rij=sum(firefly1~=firefly2);
end