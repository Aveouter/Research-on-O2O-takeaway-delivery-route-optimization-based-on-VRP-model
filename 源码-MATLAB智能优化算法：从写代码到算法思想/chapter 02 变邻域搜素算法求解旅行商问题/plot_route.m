%% TSP·�߿��ӻ�
%����route��           һ��·��
%����x,y��             x,y����
function plot_route(route,x,y)
figure
route=[route route(1)];
plot(x(route),y(route),'k-o','MarkerSize',10,'MarkerFaceColor','w','LineWidth',1.5);
xlabel('x');
ylabel('y');
end