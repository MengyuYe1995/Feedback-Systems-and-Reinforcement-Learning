clear all
clc
k=100;

a1_est_mle_total=0;a2_est_mle_total=0;
a1_est_lse_total=0;a2_est_lse_total=0;
for xxx=1:100
mu=0;                     
sigma=1;                 
b=sigma/sqrt(2);     
a=rand(1,k-2)-0.5;    
w=mu-b*sign(a).*log(1-2*abs(a)); 

a1=1.5;a2=-1.2;

y(1)=0;y(2)=0;
for i=1:k-2
    y(i+2)=a1*y(i+1)+a2*y(i)+w(i);
end

%mse

min1=1e+50;
a1_est_mle=0;a2_est_mle=0;
for i=1.45:0.0001:1.55
    for ii=-1.25:0.0001:-1.15
        total=0;
        for iii=3:k
            total=total+abs(y(iii)-i*y(iii-1)-ii*y(iii-2));
        end
        if total<min1
            min1=total;
            a1_est_mle=i;a2_est_mle=ii;
        end
    end
end
a1_est_mle_total=a1_est_mle_total+a1_est_mle;
a2_est_mle_total=a2_est_mle_total+a2_est_mle;

%lse
min2=1e50;
a1_est_lse=0;a2_est_lse=0;
for i=1.45:0.0001:1.55
    for ii=-1.25:0.0001:-1.15
        total=0;
        for iii=3:k
            total=total+(y(iii)-i*y(iii-1)-ii*y(iii-2))^2;
        end
        if total<min2
            min2=total;
            a1_est_lse=i;a2_est_lse=ii;
        end
    end
end
a1_est_lse_total=a1_est_lse_total+a1_est_lse;
a2_est_lse_total=a2_est_lse_total+a2_est_lse;
end
a1_est_mle_av=a1_est_mle_total/100;
a2_est_mle_av=a2_est_mle_total/100;
a1_est_lse_av=a1_est_lse_total/100;
a2_est_lse_av=a2_est_lse_total/100;

