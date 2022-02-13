%% 订单分批方案与萤火虫个体之间进行转换
%输入batches：             订单分批方案
%输入N：                   萤火虫个体长度
%输入orders_num：          总订单数目
%输出firefly：             由订单分批方案转换而成的萤火虫个体
function firefly=change(batches,N,orders_num)
H=size(batches,1);              	%订单分批方案中的订单批次数目
firefly=[];                     	%初始萤火虫个体为空
for i=1:H
    if (orders_num+i)<=N
        firefly=[firefly,batches{i},orders_num+i];
    else
        firefly=[firefly,batches{i}];
    end
end
if length(firefly)<N                %如果萤火虫个体长度小于N，则需要向个体添加订单批次分隔数字
    addition=(orders_num+H+1):N;
    firefly=[firefly,addition];
end
end