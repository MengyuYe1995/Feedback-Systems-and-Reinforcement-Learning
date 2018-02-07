clear all
clc
k=100;

a1_est_mle_total=0;a2_est_mle_total=0;
%a1_est_lse_total=0;a2_est_lse_total=0;
total_theta=0;
for xxx=1:100
mu=0;                     
sigma=1;                 
b=sigma/sqrt(2);     
a=rand(1,k-2)-0.5;    
w=mu-b*sign(a).*log(1-2*abs(a)); 

a1=0.8;a2=-0.5;

y(1)=1;y(2)=1;
for i=1:k-2
    y(i+2)=a1*y(i+1)+a2*y(i)+w(i);
end

%mse(brutal force)

min1=1e+05;
a1_est_mle=0;a2_est_mle=0;
for i=0.75:0.001:0.85
    for ii=-0.55:0.001:-0.45
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
% 
% %lse(brutal force)
% min2=1e5;
% a1_est_lse=0;a2_est_lse=0;
% for i=0.75:0.001:0.85
%     for ii=-0.55:0.001:-0.45
%         total=0;
%         for iii=3:k
%             total=total+(y(iii)-i*y(iii-1)-ii*y(iii-2))^2;
%         end
%         if total<min2
%             min2=total;
%             a1_est_lse=i;a2_est_lse=ii;
%         end
%     end
% end
% a1_est_lse_total=a1_est_lse_total+a1_est_lse;
% a2_est_lse_total=a2_est_lse_total+a2_est_lse;


%lse
for i=2:99
    fi(i-1,:)=[y(i),y(i-1)];
end

theta_est_lse_function=pinv(fi)*y(3:100)';
total_theta=total_theta+theta_est_lse_function;
end


a1_est_mle_av=a1_est_mle_total/100;
a2_est_mle_av=a2_est_mle_total/100;
% a1_est_lse_av=a1_est_lse_total/100;
% a2_est_lse_av=a2_est_lse_total/100;
theta_est_av_lse=total_theta/100
theta_est_av_mse=[a1_est_mle_av,a2_est_mle_av]'