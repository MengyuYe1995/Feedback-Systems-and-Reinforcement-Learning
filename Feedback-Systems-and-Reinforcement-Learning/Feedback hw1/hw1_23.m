clear all
u=10*rand(1,50);
b1=1;b2=2;
for k=3:50
    y(1)=0;
    y(2)=b1*u(1);
    y(k)=b1*u(k-1)+b2*u(k-2);
end
err_min=100;
for b1_est=0.01:0.01:4
    for b2_est=0.01:0.01:4
        err=0;
        y_est(1)=0;
        y_est(2)=b1_est*u(1);
        for k=3:50
            y_est(k)=b1_est*u(k-1)+b2_est*u(k-2);
        end
        
        for k=1:50
            err=err+abs(y(k)-y_est(k));
        end
        
        if err<err_min
                b1_opt=b1_est;
                b2_opt=b2_est;
                err_min=err;
        end
    end
end

