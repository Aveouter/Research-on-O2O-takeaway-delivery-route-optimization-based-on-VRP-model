%% 更新全部个体
%输入Population：  种群
%输入cluster_num： 聚类数目
%输入cluster_row： 每个聚类中个体的数目
%输入Idx：         每个个体所对应的所在聚类的编号
%输入order_cluster：将每个聚类中的个体按照目标函数值排序后的元胞数组
%输入p_one：       选择1个聚类的概率
%输入p_one_center：选择1个聚类中聚类中心的概率
%输入p_two_center：选择2个聚类中聚类中心的概率
%输入v_num：       车辆最大允许使用数目
%输入cusnum：      顾客数目
%输入cap：         车辆最大装载量
%输入demands：     顾客需求量
%输入pdemands：    顾客回收量
%输入a,b：         顾客时间窗结束时间[a[i],b[i]]
%输入s：           对每个顾客的服务时间
%输入L：           仓库时间窗结束时间
%输入dist：        距离矩阵
%输入v：           车辆行驶速度
%输入alpha：       违反的装载量约束的惩罚函数系数
%输入belta：       违反时间窗约束的惩罚函数系数
%输出Population：  更新后的种群
function Population=update_Population(Population,cluster_num,cluster_row,Idx,order_cluster,p_one,p_one_center,p_two_center...
    ,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta)
NIND=size(Population,1);            %个体数目
%% 更新这NIND个个体
for i=1:NIND
    %如果随机数小于选择1个聚类的概率，则随机选择1个聚类
    if rand()<p_one
        select_one_cluster=randi([1,cluster_num],1,1); %选择选择一个聚类
        %如果随机数小于选择1个聚类中聚类中心的概率，或当前聚类中只有一个个体
        if rand()<p_one_center||cluster_row(select_one_cluster)==1
            select_ind=order_cluster{select_one_cluster,1}(1,:);        %选择当前解的聚类中心（只有一个个体时，就选择该个体）
        else
            r_1= randi([2,cluster_row(select_one_cluster)],1,1);        %随机选择当前聚类中除聚类中心外的其它个体序号
            select_ind=order_cluster{select_one_cluster,1}(r_1,:);      %随机选择当前聚类中除聚类中心外的其它个体
        end
        indi_temp=Swap(select_ind);                                     %将该个体进行交换操作
    else %如果随机数不小于选择1个聚类的概率，则随机选择2个聚类
        cluster_two=[0,0];                                              %随机产生两个聚类的序号
        while cluster_two(1,1)==cluster_two(1,2)
            cluster_two=randi([1,cluster_num],1,2);                     %这两个聚类序号不能相同
        end
        %如果随机数小于选择2个聚类中聚类中心的概率，或当前两个聚类中都只有一个个体
        if (rand()<p_two_center)||(cluster_row(cluster_two(1,1))==1&&cluster_row(cluster_two(1,2))==1)
            %选择这2个聚类中聚类中心
            select_ind1=order_cluster{cluster_two(1,1),1}(1,:);      %第一个被选择的聚类中心
            select_ind2=order_cluster{cluster_two(1,2),1}(1,:);      %第二个被选择的聚类中心
        else
            %如果第1个选择的聚类中只有一个个体
            if cluster_row(cluster_two(1,1))==1
                r_2=randi([2,cluster_row(cluster_two(1,2))],1,1);        %选择第2个聚类中除聚类中心外的其它个体
                select_ind1=order_cluster{cluster_two(1,1),1}(1,:);      %第一个聚类中被选择的个体
                select_ind2=order_cluster{cluster_two(1,2),1}(r_2,:);    %第二个聚类中被选择的个体
            elseif cluster_row(cluster_two(1,2))==1  %如果第2个选择的聚类中只有一个个体
                r_3=randi([2,cluster_row(cluster_two(1,1))],1, 1);        %选择第1个聚类中除聚类中心外的其它个体
                select_ind1=order_cluster{cluster_two(1,1),1}(r_3,:);     %第一个聚类中被选择的个体
                select_ind2=order_cluster{cluster_two(1,2),1}(1,:);       %第二个聚类中被选择的个体
            elseif cluster_row(cluster_two(1,1))>1&&cluster_row(cluster_two(1,2))>1
                %%选择这2个聚类中除聚类中心外的其它个体
                r_4=randi([2,cluster_row(cluster_two(1,1))],1,1);
                r_5=randi([2,cluster_row(cluster_two(1,2))],1,1);
                select_ind1=order_cluster{cluster_two(1,1),1}(r_4,:);       %第一个聚类中被选择的个体
                select_ind2=order_cluster{cluster_two(1,2),1}(r_5,:);       %第二个聚类中被选择的个体
            end
        end
        [child1,child2]=OX(select_ind1,select_ind2);                        %交叉
        Obj1=ObjFunction(child1,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
        Obj2=ObjFunction(child2,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
        %如果子代个体1目标函数值更小，则将indi_temp赋值为child1，否则赋值为child2
        if Obj1<Obj2
            indi_temp=child1;
        else
            indi_temp=child2;
        end
    end
    fit_indi_temp=ObjFunction(indi_temp,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v,alpha,belta);
    %如果fit_indi_temp比原来位置上的个体目标函数值更小，则更新该位置上的个体
    if fit_indi_temp<order_cluster{Idx(i),2}(1,:)
        Population(i,:) =indi_temp(1,:);
    end
end
end