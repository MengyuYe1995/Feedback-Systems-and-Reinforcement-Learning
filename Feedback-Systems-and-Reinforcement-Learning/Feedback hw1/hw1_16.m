clear all
P=[0 1/2 0 1/2 0 0 0 0 0;1/3 0 1/3 0 1/3 0 0 0 0;0 1/2 0 0 0 1/2 0 0 0;1/3 0 0 0 1/3 0 1/3 0 0;
    0 1/4 0 1/4 0 1/4 0 1/4 0;0 0 1/3 0 1/3 0 0 0 1/3;0 0 0 0 0 0 1 0 0;0 0 0 0 1/3 0 1/3 0 1/3;
    0 0 0 0 0 1/2 0 1/2 0];
n=10;i=1;
%For a transition probability matrix P
%obtain first passage probabilities from state
%i to all states in 1:n steps. The output is
%the matrix H with (k,j)-entry is hij(k), where
%k=1:n. In other words, the columns are indexed
%by the destination and the rows are indexed by
%the number of time steps till first passage.
G=P;
H=[P(i,:)];
E=1-eye(size(P));
for m=2:n
    G=P*(G.*E);
    H=[H;G(i,:)];
end