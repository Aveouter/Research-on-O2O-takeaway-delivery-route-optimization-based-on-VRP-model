%% 第二种交叉方式
%输入curInd：          当前鲸鱼个体
%输入bestInd：         全局最优鲸鱼个体
%输入cusnum：          顾客数目
%输入cap：             货车最大装载量
%输入demands：         顾客需求量
%输入dist：            距离矩阵
%输入belta：           违反装载量约束的惩罚函数系数
%输出cur_ind：         更新位置后的当前鲸鱼个体
function cur_ind=cross2(cur_ind,best_ind,cusnum,cap,demands,dist,belta)
N=numel(cur_ind);                    %鲸鱼个体长度
sel_num=randi([1,N],1,1);           %从当前鲸鱼个体中随机选择元素的数目
ran_seq=randperm(N);                %1~N的随机排列

sel_pos1=ran_seq(1:sel_num);        %当前鲸鱼个体中被选择出的位置集合
sel_pos1=sort(sel_pos1);            %将sel_pos1升序排列
sel_ele1=cur_ind(sel_pos1);          %当前鲸鱼个体中被选择出的元素集合

sel_pos2=zeros(1,sel_num);          %初始化全局最优鲸鱼个体中被选择出的位置集合
for i=1:sel_num
    for j=1:N
        if sel_ele1(i)==best_ind(j)
            sel_pos2(i)=j;
        end
    end
end
sel_pos2=sort(sel_pos2);            %将sel_pos2升序排列
sel_ele2=best_ind(sel_pos2);         %全局最优鲸鱼个体中被选择出的元素集合

%% 更新鲸鱼个体中的各个元素
ind1=cur_ind;                        %初始化交叉后的当前鲸鱼个体
ind2=best_ind;                       %初始化交叉后的全局最优鲸鱼个体
ind1(sel_pos1)=sel_ele2;
ind2(sel_pos2)=sel_ele1;
%% 计算交叉后的两个鲸鱼个体的目标函数值
obj1=obj_function(ind1,cusnum,cap,demands,dist,belta);
obj2=obj_function(ind2,cusnum,cap,demands,dist,belta);
%% 选择目标函数值更小的鲸鱼个体作为当前鲸鱼个体
if obj1<obj2
    cur_ind=ind1;
else
    cur_ind=ind2;
end
end