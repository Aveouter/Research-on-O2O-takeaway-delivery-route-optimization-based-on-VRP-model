%% 根据VC整理出FVC，将VC中空的配送路线删除
%输入VC：          配送方案，即每辆车所经过的顾客
%输出FVC：         删除空配送路线后的VC
%输出NV：          车辆使用数目
function [FVC,NV]=deal_vehicles_customer(VC)
VC(cellfun(@isempty,VC))=[];  %删除cell数组中的空元胞
FVC=VC;                       %将VC赋值给fVC
NV=size(FVC,1);               %新方案中车辆使用数目
end