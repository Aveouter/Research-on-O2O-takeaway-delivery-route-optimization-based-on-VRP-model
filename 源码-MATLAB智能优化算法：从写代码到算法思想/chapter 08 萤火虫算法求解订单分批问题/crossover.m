%% 交叉操作
%输入firefly1：            萤火虫个体1
%输入firefly2：            萤火虫个体2
%输入cross_len：           交叉长度，大于等于2
%输出firefly1：            交叉后的萤火虫个体1
%输出firefly2：            交叉后的萤火虫个体2
function [firefly1,firefly2]=crossover(firefly1,firefly2,cross_len)
N=numel(firefly1);              %萤火虫个体编码长度
range=N-cross_len+1;            %起始交叉点选择范围
s=randi([1,range],1,1);         %随机选择起始点
e=s+cross_len-1;                %根据交叉长度，确定交叉终点
a0=[firefly2(s:e),firefly1];    %将萤火虫2的交叉片段移动到萤火虫1前
b0=[firefly1(s:e),firefly2];    %将萤火虫1的交叉片段移动到萤火虫2前
for i=1:numel(a0)
    aindex=find(a0==a0(i));
    bindex=find(b0==b0(i));
    if numel(aindex)>1
        a0(aindex(2))=[];       %将萤火虫1个体中第2个重复的元素删除
    end
    if numel(bindex)>1
        b0(bindex(2))=[];       %将萤火虫1个体中第2个重复的元素删除
    end
    if i==numel(firefly1)
        break
    end
end
firefly1=a0;                    %删除重复元素的萤火虫个体1
firefly2=b0;                    %删除重复元素的萤火虫个体2
end