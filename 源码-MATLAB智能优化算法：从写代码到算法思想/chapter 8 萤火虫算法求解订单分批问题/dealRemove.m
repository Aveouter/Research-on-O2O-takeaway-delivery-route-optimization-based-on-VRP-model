%% 将移除集合中的订单从当前订单分批方案中移除
%输入removed：         将被移除的订单
%输入batches：         当前订单分批方案
%输出r_batches：       移除后的订单分批方案
function r_batches=dealRemove(removed,batches)
r_batches=batches;              %初始将batches赋值给r_batches
H=size(batches,1);              %当前订单分批方案中订单批次数目
for i=1:H
    batch=batches{i};           %第i批次订单
    findri=find(batch==removed,1,'first');  %寻找removed在batch中的位置，不存在返回空
    %如果在第i批次订单中找到被移除的订单removed，则将其从batch中移除，然后跳出循环
    if ~isempty(findri)
        batch(batch==removed)=[];   %将removed从batch中移除
        r_batches{i}=batch;         %更新r_batches中的第i批次订单
        break;          
    end 
end
r_batches=deal_batches(r_batches);
end