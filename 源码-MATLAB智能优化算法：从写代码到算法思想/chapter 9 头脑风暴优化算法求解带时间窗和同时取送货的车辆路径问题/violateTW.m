%% ���㵱ǰ���ͷ���Υ����ʱ�䴰Լ��
%����VC��                          ÿ�����������Ĺ˿�
%����a,b��                         �˿�ʱ�䴰����ʱ��[a[i],b[i]]
%����s��                           ��ÿ���˿͵ķ���ʱ��
%����L��                           �ֿ�ʱ�䴰����ʱ��
%����dist��                        �������
%����v��                           ������ʻ�ٶ�
%���w��                           ��ǰ���ͷ���Υ����ʱ�䴰Լ��֮��
function w=violateTW(VC,a,b,s,L,dist,v)
NV=size(VC,1);                              %���ó�������
w=0;
bsv=begin_s_v(VC,a,s,dist,v);               %����ÿ��������·�����ڸ����㿪ʼ�����ʱ�䣬�����㷵�زֿ�ʱ��
for i=1:NV
    route=VC{i};
    bs=bsv{i};
    l_bs=length(bsv{i});
    for j=1:l_bs-1
        if bs(j)>b(route(j))
            w=w+bs(j)-b(route(j));
        end
    end
    if bs(end)>L
        w=w+bs(end)-L;
    end
end
end