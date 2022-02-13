%% 计算当前配送方案违反的时间窗约束
%输入VC：                          每辆车所经过的顾客
%输入a,b：                         顾客时间窗结束时间[a[i],b[i]]
%输入s：                           对每个顾客的服务时间
%输入L：                           仓库时间窗结束时间
%输入dist：                        距离矩阵
%输入v：                           车辆行驶速度
%输出w：                           当前配送方案违反的时间窗约束之和
function w=violateTW(VC,a,b,s,L,dist,v)
NV=size(VC,1);                              %所用车辆数量
w=0;
bsv=begin_s_v(VC,a,s,dist,v);               %计算每辆车配送路线上在各个点开始服务的时间，还计算返回仓库时间
for i=1:NV
    route=VC{i};
    bs=bsv{i};
    l_bs=length(bsv{i});
    for j=1:l_bs-1
        if bs(j)>b(route(j))
            w=w+bs(j)-b(route(j));
        end
    end
    if bs(end)>L
        w=w+bs(end)-L;
    end
end
end