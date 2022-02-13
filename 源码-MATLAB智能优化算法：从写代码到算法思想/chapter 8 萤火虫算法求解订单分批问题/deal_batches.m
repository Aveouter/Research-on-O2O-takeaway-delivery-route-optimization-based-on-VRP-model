%% 根据batches整理出fbatches，将batches中空的批次删除
%输入batches：          订单分批方案，即每批订单所包含的订单
%输出fbatches：         删除空批次后的batches
%输出batches_num：      订单分批数目
function [fbatches,batches_num]=deal_batches(batches)
batches(cellfun(@isempty,batches))=[];  %删除cell数组中的空元胞
fbatches=batches;                       %将batches赋值给fbatches
batches_num=size(fbatches,1);           %删除空元胞数组后，订单分批方案中的订单批次数目
end