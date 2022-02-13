%% 第一种交叉方式
%输入curInd：          当前鲸鱼个体
%输入bestInd：         全局最优鲸鱼个体
%输入cusnum：          顾客数目
%输入cap：             货车最大装载量
%输入demands：         顾客需求量
%输入dist：            距离矩阵
%输入belta：           违反装载量约束的惩罚函数系数
%输出cur_ind：         更新位置后的当前鲸鱼个体
function cur_ind=cross1(cur_ind,best_ind,cusnum,cap,demands,dist,belta)
N=numel(cur_ind);                %鲸鱼个体长度
sel_pos=[];                     %选择出的元素集合
init_pos=randi([1,N],1,1);      %从当前鲸鱼个体中随机选择一个位置
sel_pos=[sel_pos,init_pos];     %将init_pos添加到sel_pos中
init_ele1=cur_ind(init_pos);     %当前鲸鱼个体init_pos位置上的元素
init_ele2=best_ind(init_pos);    %全局最优鲸鱼个体init_pos位置上的元素
next_ele2=init_ele2;            %初始将全局最优鲸鱼个体中下一个被选中的元素赋值为init_ele2
if init_ele1~=init_ele2
    while init_ele1~=next_ele2
        cur_pos= find(cur_ind==next_ele2,1,'first');         %当前选中的位置
        next_ele2=best_ind(cur_pos);                         %全局最优鲸鱼个体cur_pos位置上的元素
        sel_pos=[sel_pos,cur_pos];                          %将cur_pos添加到sel_pos中
    end
end
%% 更新鲸鱼个体中的各个元素
ind1=best_ind;                               %初始化交叉后的当前鲸鱼个体
ind2=cur_ind;                                %初始化交叉后的全局最优鲸鱼个体
ind1(sel_pos)=cur_ind(sel_pos);
ind2(sel_pos)=best_ind(sel_pos);
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