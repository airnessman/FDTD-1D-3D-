% �ļ����������ɿռ�һάFDTD����
% �������������Ҳ�
% ����λ�ã����������

clc; clear; close all;
% ���������ó�ʼ����
NSTEPS= 1000;
KE= 200; 
ex(1:KE)= 0.0;
hy(1:KE)= 0.0;
kstart =100;
T= 0;
epsilon= 4;
cb(1:kstart)=0.5;
cb(kstart:KE)=0.5/epsilon;

freq_in= 700* 1e6;
ddx= 0.01;
dt=ddx/(2*3e8);

t0 = 40.0;  spread = 12;

%---�߽�������ʼ��
ex_low_m1 = 0.0;ex_low_m2 = 0.0;
ex_high_m1 = 0.0;ex_high_m2 = 0.0;

for n= 1:NSTEPS
    T=T+1; 
    for k=1:KE-1
      ex(k+1)= ex(k+1) +cb(k)*(hy(k) - hy(k+1))  ;     
    end
    
    pulse = sin(2*pi*freq_in*dt*T);
    ex(5) = ex(5)+pulse;
    
    ex(1)=ex_low_m2;  ex_low_m2 = ex_low_m1; ex_low_m1 = ex(2);
    ex(KE-1)= ex_high_m2;  ex_high_m2 = ex_high_m1; ex_high_m1=ex(KE-2);
 
    for k=1:KE-1
      hy(k)= hy(k) +0.5*(ex(k) - ex(k+1))  ;     
    end 
    
%     
    if(T==150)
        subplot(2,1,1);
        plot(ex);
        ylabel('ex');
        axis([0 KE-1 -1.2 1.2]);
        title('T=100');
    end
        if(T==425)
        subplot(2,1,2);
        plot(ex);
        ylabel('ex');
        axis([0 KE-1 -1.2 1.2]);
        title('T=425');
    end
    
% figure(1);
% plot(ex);
% axis([0 KE-1 -1.2 1.2]);    
end