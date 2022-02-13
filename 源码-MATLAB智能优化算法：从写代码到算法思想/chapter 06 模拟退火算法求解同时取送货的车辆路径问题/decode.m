%% ����ǰ��ת��Ϊ���ͷ���
%����Scurr��       ��ǰ��
%����v_num��       �����������ʹ����Ŀ
%����cusnum��      �˿���Ŀ
%����cap��         �������װ����
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����dist��        �������
%���VC��          ���ͷ�������ÿ�����������Ĺ˿�
%���NV��          ����ʹ����Ŀ
%���TD��          ������ʻ�ܾ���
%���violate_num�� Υ��Լ��·����Ŀ
%���violate_cus�� Υ��Լ���˿���Ŀ
function [VC,NV,TD,violate_num,violate_cus]=decode(Scurr,v_num,cusnum,cap,demands,pdemands,dist)
violate_num=0;                                      %Υ��Լ��·����Ŀ
violate_cus=0;                                      %Υ��Լ���˿���Ŀ
VC=cell(v_num,1);                                  %ÿ�����������Ĺ˿�
count=1;                                            %��������������ʾ��ǰ����ʹ����Ŀ
location0=find(Scurr>cusnum);                       %�ҳ��������������ĵ�λ��
for i=1:length(location0)
    if i==1                                         %��1���������ĵ�λ��
        route=Scurr(1:location0(i));                %��ȡ������������֮���·��
        route(route==Scurr(location0(i)))=[];       %ɾ��·���������������
    else
        route=Scurr(location0(i-1):location0(i));   %��ȡ������������֮���·��
        route(route==Scurr(location0(i-1)))=[];     %ɾ��·���������������
        route(route==Scurr(location0(i)))=[];       %ɾ��·���������������
    end
    VC{count}=route;                                %�������ͷ���
    count=count+1;                                  %����ʹ����Ŀ
end
route=Scurr(location0(end):end);                    %���һ��·��       
route(route==Scurr(location0(end)))=[];             %ɾ��·���������������
VC{count}=route;                                    %�������ͷ���
[VC,NV]=deal_vehicles_customer(VC);                 %��VC�пյ������Ƴ�
for j=1:NV
    route=VC{j};
    flag=JudgeRoute(route,demands,pdemands,cap);    %�ж�һ��·���Ƿ�����װ����Լ����1��ʾ���㣬0��ʾ������        
    if flag==0
        violate_cus=violate_cus+length(route);      %�������·��������Լ������Υ��Լ���˿���Ŀ�Ӹ���·���˿���Ŀ
        violate_num=violate_num+1;                  %�������·��������Լ������Υ��Լ��·����Ŀ��1
    end
end
TD=travel_distance(VC,dist);                        %�÷���������ʻ�ܾ���
end