% �ļ����������ɿռ�һάFDTD����
% ������������˹����
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

t0 = 40.0;  spread = 12;

%---�߽�������ʼ��
ex_low_m1 = 0.0;ex_low_m2 = 0.0;
ex_high_m1 = 0.0;ex_high_m2 = 0.0;

for n= 1:NSTEPS
    T=T+1; 
    for k=1:KE-1
      ex(k+1)= ex(k+1) +cb(k)*(hy(k) - hy(k+1))  ;     
    end
    
    pulse = exp(-0.5*((t0-T)/spread)^2);
    ex(5) = ex(5)+pulse;
    
    ex(1)=ex_low_m2;  ex_low_m2 = ex_low_m1; ex_low_m1 = ex(2);
    ex(KE-1)= ex_high_m2;  ex_high_m2 = ex_high_m1; ex_high_m1=ex(KE-2);

    
    for k=1:KE-1
      hy(k)= hy(k) +0.5*(ex(k) - ex(k+1))  ;     
    end 
    %---��ͼ
    if(T==100)
        subplot(4,1,1);
        plot(ex);
        ylabel('ex');
        axis([0 KE-1 -0.5 1.2]);
        title('T=100');
    end
    if(T==220)
        subplot(4,1,2);
        plot(ex);
        ylabel('ex');
        axis([0 KE-1 -0.5 1.2]);
        title('T=220');
    end    
    if(T==320)
        subplot(4,1,3);
        plot(ex);
        ylabel('ex');
        axis([0 KE-1 -0.5 1.2]);
        title('T=320');
    end    
    if(T==440)
        subplot(4,1,4);
        plot(ex);
        ylabel('ex');
        xlabel('�ռ�������');
        axis([0 KE-1 -0.5 1.2]);
        title('T=440');
    end 
    
% figure(1);
% plot(hy);
% axis([0 KE-1 -0.5 1.2]);
end

