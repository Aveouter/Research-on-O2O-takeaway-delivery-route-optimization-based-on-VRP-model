%% ����insertion�����������ǰ·��route���ܾ���Ĳ�ֵ
%����route��            һ��·��
%����dist��             �������
%����i��j��             ��ת��i,j
%���delta1��           insertion��·�ߵ��ܾ���-insertionǰ·�ߵ��ܾ���
function delta3=cal_delta3(route,dist,i,j)
N=numel(route);         %������Ŀ
if i<j
    if (i==1) && (j==N)
        delta3=0;
    elseif (i==1) && (j==2)
        delta3=-(dist(route(N),route(i))+dist(route(j),route(j+1)))+...
            (dist(route(N),route(j))+dist(route(i),route(j+1)));
    elseif i==1
        delta3=-(dist(route(N),route(i))+dist(route(i),route(i+1))+dist(route(j),route(j+1)))+...
            (dist(route(N),route(i+1))+dist(route(j),route(i))+dist(route(i),route(j+1)));
    elseif (i==N-1)&&(j==N)
        delta3=-(dist(route(i-1),route(i))+dist(route(j),route(1)))+...
            (dist(route(i-1),route(j))+dist(route(i),route(1)));
    elseif j==N
        delta3=-(dist(route(i-1),route(i))+dist(route(i),route(i+1))+dist(route(j),route(1)))+...
            (dist(route(i-1),route(i+1))+dist(route(j),route(i))+dist(route(i),route(1)));
    elseif (j-i)==1
        delta3=-(dist(route(i-1),route(i))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(j))+dist(route(i),route(j+1)));
    else
        delta3=-(dist(route(i-1),route(i))+dist(route(i),route(i+1))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(i+1))+dist(route(j),route(i))+dist(route(i),route(j+1)));
    end
else
    if (i==N) && (j==1)
        delta3=-(dist(route(i-1),route(i))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(j))+dist(route(i),route(j+1)));
    elseif (i-j)==1
        delta3=0;
    elseif i==N
        delta3=-(dist(route(i-1),route(i))+dist(route(i),route(1))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(1))+dist(route(j),route(i))+dist(route(i),route(j+1)));
    else
        delta3=-(dist(route(i-1),route(i))+dist(route(i),route(i+1))+dist(route(j),route(j+1)))+...
            (dist(route(i-1),route(i+1))+dist(route(j),route(i))+dist(route(i),route(j+1)));
    end
end
end