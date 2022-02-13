%% 将removed中的订单插回各订单分批中
%输入removed：             被移除订单的集合
%输入r_batches：           移除若干个订单后的订单分批方案
%输入orders：              每个订单所包含的物品信息
%输入capacity：            设备最大装载量
%输入item_weight：         每个储位品项的重量
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从通道进入拣选通道或从拣选通道进入通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出p_batches：           修复后的订单分批方案
function p_batches=greedy_ins(removed,r_batches,orders,capacity,item_weight,...
    side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
%将removed中订单按照拣选行走距离由大到小排序
removed=removed_down_sort(removed,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
p_batches=r_batches;            %初始将修复后的订单分批方案赋值为破坏后的订单分批方案
nr=numel(removed);              %移除集合中订单数目
ri_no=zeros(nr,1);              %存储将removed中各个订单插回时的最佳插回订单批次编号
ri_cost=zeros(nr,1);            %存储将removed中各个订单插回时的最佳插入成本
ri_batch=cell(nr,1);            %存储将removed中各个订单插回时的最佳插回的订单批次
%% 将removed中的各个订单逐个插回当前订单分批方案中
for i=1:nr
    order=removed(i);           %当前要插回的订单
    dec=[];                     %记录order的插入成本
    ins_no=[];                  %记录order可以插回的订单批次序号
    count=1;                    %计数器
    ins_b=cell(count,1);    %记录order可以插回的订单批次结果
    for j=1:size(p_batches,1)
        batch=p_batches{j};     %第j批次订单分批
        [new_batch,flag,deltaC]=ins_batch(order,orders,batch,capacity,item_weight,...
            side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
        %flag=1表示能插入，flag=0表示不能插入
        if flag==1
            ins_b{count,1}=new_batch;
            dec=[dec;deltaC];
            ins_no=[ins_no;j];
            count=count+1;      %计数器增加
        end
    end
    %如果存在满足约束的ins_batch，则更新插回订单批次编号ri_no、最佳插入成本ri_cost、插回的订单批次ri_batch
    if ~isempty(ins_no)
        [sd,sdi]=sort(dec);                 %将dec升序排列
        insc=ins_no(sdi);                   %将ins_no的序号与dec排序后的序号对应
        ri_no(i)=insc(1);                   %更新order插回时的最佳插回订单批次编号
        ri_cost(i)=sd(1);                   %更新插回时的最佳插入成本
        ri_batch{i}=ins_b{sdi(1)};      %更新插回时的最佳插回的订单批次
    else
        %如果不存在满足约束的ins_batch，则新增加一批次订单
        ri_no(i)=size(p_batches,1)+1;       %新增加一批次订单
        ri_cost(i)=shpath(order,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle);
        ri_batch{i}=order;
    end
    r_ins=ri_no(i);                         %插回订单批次的编号
    p_batches{r_ins}=ri_batch{i};           %更新p_batches
end
end