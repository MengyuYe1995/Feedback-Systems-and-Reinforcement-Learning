clear; close all; clc;

N = 1e2;
queueStates = 5; % States per queue: 0-4
queueNum = 2; % Control of 2 queues with single server

arriRate = [0.3 0.2];%rand(2,1)*0.5;
serveRate = [0.3 0.2];%rand(2,1)*0.5;
waitCost = [0.9,1];
J = zeros(N,queueStates*queueStates);
J(N,1:queueStates*queueStates) = waitCost*[ceil((1:(queueStates*queueStates))/queueStates);mod(0:(queueStates*queueStates-1),queueStates)+1];

for time = N-1:-1:1
    Jtemp = zeros(queueStates*queueStates,2);
    for act = 1:2
        u = [2-act,act-1]; % Action [1,0] or [0,1]
        % make the transition matrices for 2 queues
        P = zeros(queueStates,queueStates,queueNum); %transition matrices for 2 queues
        for ind1 = 1:queueNum
            sRate = u(ind1)*serveRate(ind1);
            tempVec = [1-arriRate(ind1),1-arriRate(ind1)-sRate,1-arriRate(ind1)-sRate,1-arriRate(ind1)-sRate,1-sRate];
            P(:,:,ind1) = diag(tempVec);
            for k = 1:queueStates-1       
                P(k,k+1,ind1) = arriRate(ind1);
                P(k+1,k,ind1) = sRate;
            end
        end    
        % transition matrix for the overall system
        for ind2 = 1:queueStates*queueStates
            for ind3 = 1:queueStates*queueStates
                PP(ind2,ind3) = P(ceil(ind2/5),ceil(ind3/5),1)*P(mod(ind2-1,5)+1,mod(ind3-1,5)+1,2);
            end
        end        
        for ind4 = 1:queueStates*queueStates
            Jtemp(ind4,act) = waitCost*[ceil(ind4/queueStates);mod(ind4-1,queueStates)+1]...
                +PP(ind4,:)*J(time+1,:)';
        end
    end
    for ind5 = 1:queueStates*queueStates
        [J(time,ind5),action(time,ind5)] = min(Jtemp(ind5,:));
    end
end
