%% ����ǰ�������Ϊ���ͷ���
%����Individual��  ��ǰ����
%����v_num��       �����������ʹ����Ŀ
%����cusnum��      �˿���Ŀ
%����cap��         �������װ����
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����a��           �˿�ʱ�䴰��ʼʱ��[a[i],b[i]]
%����b��           �˿�ʱ�䴰����ʱ��[a[i],b[i]]
%����L��           ��������ʱ�䴰����ʱ��
%����s��           �ͻ���ķ���ʱ��
%����dist��        �������
%����v��           ������ʻ�ٶ�
%���VC��          ���ͷ�������ÿ�����������Ĺ˿�
%���NV��          ����ʹ����Ŀ
%���TD��          ������ʻ�ܾ���
%���violate_num�� Υ��Լ��·����Ŀ
%���violate_cus�� Υ��Լ���˿���Ŀ
function [VC,NV,TD,violate_num,violate_cus]=decode(Individual,v_num,cusnum,cap,demands,pdemands,a,b,s,L,dist,v)
violate_num=0;                                      %Υ��Լ��·����Ŀ
violate_cus=0;                                      %Υ��Լ���˿���Ŀ
VC=cell(v_num,1);                                   %ÿ�����������Ĺ˿�
count=1;                                            %��������������ʾ��ǰ����ʹ����Ŀ
location0=find(Individual>cusnum);                  %�ҳ��������������ĵ�λ��
for i=1:length(location0)
    if i==1                                              %��1���������ĵ�λ��
        route=Individual(1:location0(i));                %��ȡ������������֮���·��
        route(route==Individual(location0(i)))=[];       %ɾ��·���������������
    else
        route=Individual(location0(i-1):location0(i));   %��ȡ������������֮���·��
        route(route==Individual(location0(i-1)))=[];     %ɾ��·���������������
        route(route==Individual(location0(i)))=[];       %ɾ��·���������������
    end
    VC{count}=route;                                %�������ͷ���
    count=count+1;                                  %����ʹ����Ŀ
end
route=Individual(location0(end):end);               %���һ��·��       
route(route==Individual(location0(end)))=[];        %ɾ��·���������������
VC{count}=route;                                    %�������ͷ���
[VC,NV]=deal_vehicles_customer(VC);                 %��VC�пյ������Ƴ�
for j=1:NV
    route=VC{j};
    %�ж�һ������·���ϵĸ������Ƿ�����װ����Լ����ʱ�䴰Լ����1��ʾ���㣬0��ʾ������
    flag=JudgeRoute(route,demands,pdemands,cap,a,b,s,L,dist,v); 
    if flag==0
        violate_cus=violate_cus+length(route);      %�������·��������Լ������Υ��Լ���˿���Ŀ�Ӹ���·���˿���Ŀ
        violate_num=violate_num+1;                  %�������·��������Լ������Υ��Լ��·����Ŀ��1
    end
end
TD=travel_distance(VC,dist);                        %�÷���������ʻ�ܾ���
end