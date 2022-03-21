% 文件描述：自由空间一维FDTD仿真，有边界吸收
% 激励描述：高斯脉冲
% 激励位置：网格中间

clc; clear; close all;
% ———设置初始条件
NSTEPS= 1000;
KE= 200; 
ex(KE)= 0.0;
hy(KE)= 0.0;
kc= KE/2;

t0 = 40.0;  spread = 12;

%---边界条件初始化
ex_low_m1 = 0.0;ex_low_m2 = 0.0;
ex_high_m1 = 0.0;ex_high_m2 = 0.0;

for n= 1:NSTEPS
    
    for k=1:KE-1
      ex(k+1)= ex(k+1) +0.5*(hy(k) - hy(k+1))  ;     
    end
    
    pulse = exp(-0.5*((t0-n)/spread)^2);
    ex(kc) = ex(kc)+pulse;
    
    ex(1)=ex_low_m2;  ex_low_m2 = ex_low_m1; ex_low_m1 = ex(2);
    ex(KE-1)= ex_high_m2;  ex_high_m2 = ex_high_m1; ex_high_m1=ex(KE-2);
    
    for k=1:KE-1
      hy(k)= hy(k) +0.5*(ex(k) - ex(k+1))  ;     
    end 
    
    %----画图
%     if(n==100)
%         subplot(3,1,1);
%         plot(ex);
%         ylabel('ex');
%         axis([0 KE-1 -0.5 1.2]);
%         title('T=100');
%     end
%     if(n==225)
%         subplot(3,1,2);
%         plot(ex);
%         ylabel('ex');
%         axis([0 KE-1 -0.5 1.2]);
%         title('T=225');
%     end
%     if(n==250)
%         subplot(3,1,3);
%         plot(ex);
%         ylabel('ex');
%         axis([0 KE-1 -0.5 1.2]);
%         title('T=250');
%     end 



figure(1);
plot(ex);
axis([0 KE-1 -0.5 1.2]);
end
