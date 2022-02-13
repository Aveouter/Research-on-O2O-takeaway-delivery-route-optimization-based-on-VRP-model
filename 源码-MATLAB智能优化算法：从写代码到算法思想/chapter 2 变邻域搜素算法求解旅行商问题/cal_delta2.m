%% ��������route������i��jλ��֮������������У�Ȼ�����ת������ǰ��ת�����к��·������Ĳ�ֵ
%����route��            һ��·��
%����dist��             �������
%����i��j��             ��ת��i,j
%���delta2��           reversion��·�ߵ��ܾ���-reversionǰ·�ߵ��ܾ���
function delta2=cal_delta2(route,dist,i,j)
N=numel(route);                 %���и���
if i==1
    if j==N
        delta2=0;
    else
        delta2=-dist(route(j),route(j+1))-dist(route(N),route(i))+...
            dist(route(i),route(j+1))+dist(route(N),route(j));
    end
else
    if j==N
        delta2=-dist(route(i-1),route(i))-dist(route(1),route(j))+...
            dist(route(i-1),route(j))+dist(route(i),route(1));
    else
        delta2=-dist(route(i-1),route(i))-dist(route(j),route(j+1))+...
            dist(route(i-1),route(j))+dist(route(i),route(j+1));
    end
end
end