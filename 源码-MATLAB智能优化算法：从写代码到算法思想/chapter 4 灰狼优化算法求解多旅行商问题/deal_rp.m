%% 根据RP整理出fRP，将RP中空的行走路线删除
%输入RP：          行走路线方案
%输出FRP：         删除空路线后的RP
%输出m：           旅行商数目
function [FRP,m]=deal_rp(RP)
RP(cellfun(@isempty,RP))=[];  %删除cell数组中的空元胞
FRP=RP;                       %将RP赋值给fRP
m=size(FRP,1);                %新方案中所需旅行商的数目
end