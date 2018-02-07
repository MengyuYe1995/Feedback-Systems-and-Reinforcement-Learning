clear all;clc;
N=100;
lamda=[0.5 0.5];%arrival rate for each queue
mu=[0.5 0.5];%service time for each queue
cost=[1 1];%wait cost for each queue
que_core=2;%cores of queue
que_len=4;%max length of each queue
que_states=que_len+1;
state_space=(que_len+1)^2;%state space X
J=zeros(N,state_space);
J(N,:)=cost*[ceil((1:state_space)/que_states);mod(0:(state_space-1),que_states)+1];

for t=N-1:-1:1
    Jtemp = zeros(state_space,2);
    for que_choose = 1:que_core
        u = [2-que_choose,que_choose-1]; % when choose que 1 to serve,Action [1,0]|when choose que2 to serve,Action [0,1]
        %build transition matrix of each que
        P = zeros(que_states,que_states,que_choose); 
        for i = 1:que_core
            mu1 = u(i)*mu(i);%set one que's mu to be 0 if it is not served
            P(:,:,i) = diag([1-lamda(i),1-lamda(i)-mu1,1-lamda(i)-mu1,1-lamda(i)-mu1,1-mu1]);
            for k = 1:que_states-1       
                P(k,k+1,i) = lamda(i);
                P(k+1,k,i) = mu1;
            end
        end    
        %build transition matrix for ques combined as a whole system
        for ii=1:state_space
            for iii=1:state_space
                PP(ii,iii)=P(ceil(ii/5),ceil(iii/5),1)*P(mod(ii-1,5)+1,mod(iii-1,5)+1,2);
            end
        end
        for i=1:state_space
            Jtemp(i,que_choose)=cost*[ceil(i/que_states);mod(i-1,que_states)+1]+PP(i,:)*J(t+1,:)';
        end
    end
    
    for i=1:state_space
        [J(t,i),action(t,i)] = min(Jtemp(i,:));
    end
   
end