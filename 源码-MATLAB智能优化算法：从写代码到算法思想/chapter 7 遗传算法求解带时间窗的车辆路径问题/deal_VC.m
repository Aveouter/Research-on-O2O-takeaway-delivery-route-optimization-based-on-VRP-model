%% 根据VC整理出FVC，将VC中空的配送路线删除
%输入VC：          配送方案
%输出FVC：         删除空路线后的VC
%输出NV：          车辆使用数目
function [FVC,NV]=deal_VC(VC)
VC(cellfun(@isempty,VC))=[];  %删除cell数组中的空元胞
FVC=VC;                       %将VC赋值给fVC
NV=size(FVC,1);               %新方案中车辆使用数目
end