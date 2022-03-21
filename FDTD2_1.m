% �ļ����������ɿռ�һάFDTD���棬�ޱ߽�����
% ������������˹����
% ����λ�ã������м�

clc; clear; close all;
% ���������ó�ʼ����
KE= 600; 
ex(KE)= 0.0;
hy(KE)= 0.0;
kc= KE/2;

t0 = 40.0;  spread = 12;
NSTEPS= 1000;


for n= 1:NSTEPS
    
    for k=1:KE-1
      ex(k+1)= ex(k+1) +0.5*(hy(k) - hy(k+1))  ;     
    end
    
    pulse = exp(-0.5*((t0-n)/spread)^2);
    ex(kc) = ex(kc)+pulse;
    
    ex(1)=0; ex(KE-1) = 0;
    
    for k=1:KE-1
      hy(k)= hy(k) +0.5*(ex(k) - ex(k+1))  ;     
    end 
    figure(1);
    plot(ex);
    axis([0 KE-1 -1.2 1.2])

end   
 

%     subplot(2,1,1);
%     plot(ex);
%     xlabel('�ռ�������');
%     ylabel('ex');
%     axis([0 KE -1.2 1.2]);
%     subplot(2,1,2);
%     plot(hy);
%     xlabel('�ռ�������');
%     ylabel('hy');
%     axis([0 KE -1.2 1.2]);
    
    

