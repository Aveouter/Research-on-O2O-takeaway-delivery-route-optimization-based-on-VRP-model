%% ����һ��·���ܾ���
%����route��            һ��·��
%����dist��             �������
%���len��              ����·���ܾ���
function len=route_length(route,dist)
    N=numel(route);
    route=[route route(1)];
    len=0;
    for k=1:N 
        i=route(k);
        j=route(k+1); 
        len=len+dist(i,j); 
    end
end