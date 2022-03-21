% �ļ������������ͨ���ܶ�һάFDTD����
% �������������Ҳ�
% ����λ�ã����������
% �����������кĽ���
% ����λ�ã������м�

clc ; clear  ; close all;
% ���������ó�ʼ����
NSTEPS= 1000;
KE= 200; 
kstart =KE/2;
epsilon= 4;

freq_in= 700* 1e6;
epsz = 8.85419e-12;  %����н�糣��
sigma = 0.04;        %�絼��
c0=3e8;               %���ɿռ����
ddx=0.01;
dt = ddx/(2*c0);

% ������ʼ��
ga(1:KE)= 1.0 ;gb(1:KE)= 0.0 ;  %���ɿռ��������
ex(1:KE)= 0.0 ;hy(1:KE)= 0.0 ;  %��ʼ�糡���ų�����
dx(1:KE)= 0.0 ;ix(1:KE)= 0.0 ;  %��ʼ��ͨ���ܶ�����

%�������
ga(kstart + 1:KE) = 1.0/(epsilon+sigma*dt/epsz);
gb(kstart + 1:KE) = sigma*dt/epsz;

%---�߽�������ʼ��
ex_low_m1 = 0.0;ex_low_m2 = 0.0;
ex_high_m1 = 0.0;ex_high_m2 = 0.0;

for n= 1:NSTEPS
    for k=2:KE
      dx(k)= dx(k) +0.5*(hy(k-1) - hy(k))  ;     
    end

    pulse = sin(2 * pi * freq_in * dt * n);
    dx(5) = dx(5)+pulse;
    
    for k = 1:KE-1
        ex(k) = ga(k) * (dx(k) - ix(k));
        ix(k) = ix(k) +gb(k)*ex(k);
    end
    
    ex(1)=ex_low_m2;  ex_low_m2 = ex_low_m1; ex_low_m1 = ex(2);
    ex(KE-1)= ex_high_m2;  ex_high_m2 = ex_high_m1; ex_high_m1=ex(KE-2);
    
    for k=1:KE-1
      hy(k)= hy(k) +0.5*(ex(k) - ex(k+1))  ;     
    end 
    
    figure(1);
    plot(ex);
    axis([0 KE -1.5 1.5]);    
end
