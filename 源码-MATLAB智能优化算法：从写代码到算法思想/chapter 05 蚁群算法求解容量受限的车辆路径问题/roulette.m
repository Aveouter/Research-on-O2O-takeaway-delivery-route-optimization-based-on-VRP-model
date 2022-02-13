%% 轮盘赌
%输入p_value：                 下一个访问点集合中每一个点的状态转移概率
%输出index：                   轮盘赌选择的p_value的行序号
function index=roulette(p_value)
r=rand;
c=cumsum(p_value);
index=find(r<=c,1,'first');
end