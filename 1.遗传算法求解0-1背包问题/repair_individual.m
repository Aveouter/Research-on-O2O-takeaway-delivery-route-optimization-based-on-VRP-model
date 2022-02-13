%% 对违反约束的个体进行修复
%输入Individual：          个体
%输入w：                   各个物品的质量
%输入p：                   各个物品的价值
%输入cap：                 背包的载重量
%输出Individual：          修复后的个体
function Individual=repair_individual(Individual,w,p,cap)
%% 判断一个个体是否满足背包的载重量约束，1表示满足，0表示不满足
flag=judge_individual(Individual,w,cap);
%% 只有不满足约束的个体才进行修复
if flag==0
    %% 初步修复
    pack_item=find(Individual==1);                  %找出装进背包中物品的序号
    num_pack=numel(pack_item);                      %装进背包中物品的总数目
    w_pack=w(pack_item);                            %找出装进背包中物品的质量
    total_w=sum(w_pack);                            %计算装包物品的总质量
    p_pack=p(pack_item);                            %找出装进背包中物品的价值
    ratio_pack=p_pack./w_pack;                      %计算装进背包中物品的性价比=价值/质量
    [~,rps_index]=sort(ratio_pack);                 %将已经装进包中的物品按照性价比（性价比=价值?质量）由低到高进行排序
    %% 按照rps_index顺序，依次将物品从背包中移除
    for i=1:num_pack
        remove_item=pack_item(rps_index(i));        %被移除的物品的序号
        %如果移除该物品后满足背包的载重量约束，则将该物品对应的基因位改为0，然后终止循环
        if (total_w-w_pack(rps_index(i)))<=cap
            total_w=total_w-w_pack(rps_index(i));   %装包中物品总质量减少
            Individual(remove_item)=0;              %将该物品对应的基因位改为0
            break;
        else
            %如果移除该物品后依然不满足背包的载重量约束，则也要将该物品对应的基因位改为0，然后继续移除其它物品
            total_w=total_w-w_pack(rps_index(i));   %装包中物品总质量减少
            Individual(remove_item)=0;              %将该物品对应的基因位改为0
        end
    end
    %% 进一步修复
    unpack_item=find(Individual==0);                %找出此时未装进背包中物品的序号
    num_unpack=numel(unpack_item);                  %此时未装进背包中物品的总数目
    w_unpack=w(unpack_item);                        %找出此时未装进背包中物品的质量
    p_unpack=p(unpack_item);                        %找出此时未装进背包中物品的价值
    ratio_unpack=p_unpack./w_unpack;                %计算此时未装进背包中物品的性价比=价值/质量
    [~,rups_index]=sort(ratio_unpack,'descend');    %将此时未装进包中的物品按照性价比（性价比=价值?质量）由高到低进行排序
    %% 按照rups_index顺序，依次将物品装包
    for j=1:num_unpack
        pack_wait=unpack_item(rups_index(i));       %待装包物品编号
        %如果装包该物品后满足背包的载重量约束，则将该物品对应的基因位改为1，然后继续装包其它物品
        if (total_w+w_unpack(rups_index(i)))<=cap
            total_w=total_w+w_unpack(rups_index(i));%装包中物品总质量增加
            Individual(pack_wait)=1;                %将该物品对应的基因位改为1
        else
            %如果装包该物品后不满足背包的载重量约束，则终止循环
            break;
        end
    end
end
end