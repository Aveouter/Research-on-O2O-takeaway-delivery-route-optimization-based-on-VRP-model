%% ���̶�
%����p_value��                 ��һ�����ʵ㼯����ÿһ�����״̬ת�Ƹ���
%���index��                   ���̶�ѡ���p_value�������
function index=roulette(p_value)
r=rand;
c=cumsum(p_value);
index=find(r<=c,1,'first');
end