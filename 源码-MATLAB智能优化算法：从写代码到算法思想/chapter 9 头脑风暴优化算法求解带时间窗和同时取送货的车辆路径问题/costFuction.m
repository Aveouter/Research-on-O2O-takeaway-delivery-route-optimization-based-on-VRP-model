%% ���㵱ǰ���ͷ����ĳɱ�����
%����VC��          ÿ�����������Ĺ˿�
%����a,b��         �˿�ʱ�䴰����ʱ��[a[i],b[i]]
%����s��           ��ÿ���˿͵ķ���ʱ��
%����L��           ��������ʱ�䴰����ʱ��
%����dist��        �������
%����demands��     �˿�������
%����pdemands��    �˿ͻ�����
%����cap��         �������װ����
%����alpha��       Υ����װ����Լ���ĳͷ�����ϵ��
%����belta��       Υ��ʱ�䴰Լ���ĳͷ�����ϵ��
%����v��           ������ʻ�ٶ�
%���cost��        �ܳɱ� f=TD+alpha*q+belta*w
function cost=costFuction(VC,a,b,s,L,dist,demands,pdemands,cap,alpha,belta,v)
TD=travel_distance(VC,dist);
q=violateLoad(VC,demands,pdemands,cap);
w=violateTW(VC,a,b,s,L,dist,v);
cost=TD+alpha*q+belta*w;
end