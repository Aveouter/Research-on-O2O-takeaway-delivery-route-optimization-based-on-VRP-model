%% 计算在S型路线下完成一批次订单的总行走距离
%输入batch：               一批次订单
%输入orders：              每个订单所包含的物品信息
%输入side_num：            每条拣选通道一侧的储位数目
%输入depot_leftAisle：     仓库与第1条拣选通道的距离，1.5LU
%输入enter_leave_aisle：   从运输通道进入拣选通道或从拣选通道进入运输通道需要行走的距离，1LU
%输入adjacent_location：   同一条拣选通道的两个相邻储位之间的距离，1LU
%输入adjacent_aisle：      两个相邻拣选通道的距离，5LUs
%输出s_len：               按照S形拣选路径策略拣选完这批订单所行走的距离
function s_len=shpath(batch,orders,side_num,depot_leftAisle,enter_leave_aisle,adjacent_location,adjacent_aisle)
%% 将订单分批转换为所经过的储位
locs=batch_to_location(batch,orders);
%% 计算出经过所有货物的纵向通道编号
aisle_no=ceil(locs/(2*side_num));
%% 最大纵向通道编号
max_No=max(aisle_no);
%% 找出在最后一列纵向通道的货物编号
index= aisle_no==max_No;
loc_final=locs(index);
%% 找出loc_final中纵向距离最大的储位编号
right_len=rem(loc_final,side_num);
for j=1:numel(right_len)
    if right_len(1,j)==0 
        right_len(1,j)=side_num;
    end
end
[~,max_index]=max(right_len);
maxLoc=right_len(max_index);
%% 删除重复纵向通道
aisle_no=unique(aisle_no);
%% 计算所经过纵向通道的数量
long_num=numel(aisle_no);
%% 经过所有初始货物的纵向距离
if rem(long_num,2)==0
    long_len=long_num*((side_num-1)*adjacent_location+enter_leave_aisle*2);
else
    long_len1=(long_num-1)*((side_num-1)*adjacent_location+enter_leave_aisle*2);
    a=rem(maxLoc,side_num);
    if(a==0)
        long_len2=2*((side_num-1)*adjacent_location+enter_leave_aisle);
    else 
        long_len2=2*((a-1)*adjacent_location+enter_leave_aisle);
    end
    long_len=long_len1+long_len2;
end
%% 计算总的横向距离
cross_len=(max_No-1)*adjacent_aisle*2+depot_leftAisle*2;
%% 总距离
s_len=long_len+cross_len;
end