% 文件描述：自由空间一维FDTD仿真
% 激励描述：正弦波
% 激励位置：第五个网格

clc; clear; close all;
% ———设置初始条件
NSTEPS= 1000;
KE= 200; 
ex(1:KE)= 0.0;
hy(1:KE)= 0.0;
kstart =KE/2;
epsilon= 4;

freq_in= 700* 1e6;
epsz = 8.85419e-12;  %真空中介电常数
sigma = 0.04;        %电导率
c0=3e8;               %自由空间光速
dx=0.01;
dt = dx/(2*c0);

ca(1:kstart)=1.0;
cb(1:kstart)=0.5;

eaf = dt*sigma/(2*epsz*epsilon);
ca(kstart+1:KE)=(1.0-eaf)/(1.0+eaf);
cb(kstart+1:KE)=0.5/(epsilon*(1.0+eaf));

%---边界条件初始化
ex_low_m1 = 0.0;ex_low_m2 = 0.0;
ex_high_m1 = 0.0;ex_high_m2 = 0.0;

for n= 1:NSTEPS
    for k=2:KE
      ex(k)= ca(k)*ex(k) +cb(k)*(hy(k-1) - hy(k))  ;     
    end
    
    pulse = sin(2*pi*freq_in*dt*n);
    ex(5) = ex(5)+pulse;
    
    ex(1)=ex_low_m2;  ex_low_m2 = ex_low_m1; ex_low_m1 = ex(2);
    ex(KE-1)= ex_high_m2;  ex_high_m2 = ex_high_m1; ex_high_m1=ex(KE-2);
    
    for k=1:KE-1
      hy(k)= hy(k) +0.5*(ex(k) - ex(k+1))  ;     
    end 
    
    if(n==150)
        subplot(2,1,1);
        plot(ex);
        ylabel('ex');
        axis([0 KE-1 -1.5 1.5]);
        title('T=100');
    end
        if(n==600)
        subplot(2,1,2);
        plot(ex);
        ylabel('ex');
        axis([0 KE-1 -1.5 1.5]);
        title('T=600');
    end    
%     figure(1);
%     plot(ex);
%     axis([0 KE-1 -1.5 1.5]);
end

