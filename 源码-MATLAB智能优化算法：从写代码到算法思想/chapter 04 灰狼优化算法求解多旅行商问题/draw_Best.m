%% 画出旅行商行走路线方案路线图
%输入RP：              旅行商行走路线方案
%输入vertexs：         各个城市的横纵坐标
%输入start：           起（终）点城市
function draw_Best(RP,vertexs,start)
start_v=vertexs(start,:);                       %起点城市坐标
m=size(RP,1);                                   %旅行商数目
figure
hold on;box on
title('最优行走方案路线图')
hold on;
C=hsv(m);
for i=1:size(vertexs,1)
    text(vertexs(i,1)+0.5,vertexs(i,2),num2str(i));
end
for i=1:m
    route=RP{i};            %第i个旅行商的行走路线
    len=numel(route);       %第i个旅行商所访问的城市数目（包括起点和终点城市）
    fprintf('%s','旅行商',num2str(i),'：');
    for j=1:len-1  
        fprintf('%d->',route(j));
        c_pre=vertexs(route(j),:);
        c_lastone=vertexs(route(j+1),:);
        plot([c_pre(1),c_lastone(1)],[c_pre(2),c_lastone(2)],'-','color',C(i,:),'linewidth',1);
    end
    fprintf('%d',route(end));
    fprintf('\n');
end
plot(vertexs(:,1),vertexs(:,2),'ro','linewidth',1);hold on;
plot(start_v(1,1),start_v(1,2),'s','linewidth',2,'MarkerEdgeColor','b',...
    'MarkerFaceColor','b','MarkerSize',10);
end