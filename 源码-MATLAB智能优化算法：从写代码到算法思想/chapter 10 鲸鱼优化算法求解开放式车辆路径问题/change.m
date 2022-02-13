%% 配送方案与鲸鱼个体之间进行转换
%输入VC：          配送方案
%输入N：           鲸鱼个体长度
%输入cusnum：      顾客数目
%输出individual：  由配送方案转换成的鲸鱼个体
function individual=change(VC,N,cusnum)
NV=size(VC,1);                         %车辆使用数目
individual=[];
for i=1:NV
    if (cusnum+i)<=N
        individual=[individual,VC{i},cusnum+i];
    else
        individual=[individual,VC{i}];
    end
end
if length(individual)<N               %如果鲸鱼个体长度小于N，则需要向鲸鱼个体添加配送中心编号
    supply=(cusnum+NV+1):N;
    individual=[individual,supply];
end
end