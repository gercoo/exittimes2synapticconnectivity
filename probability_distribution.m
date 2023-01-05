function T1_2 = probability_distribution(G)
%% estimate probability for different states for different background activity

% probability distribution

U = potential_gradient_20220818(G);
% exp(-2U/s)/Z;
% state 1: 0-0.6
% state 2: 0.6-1.5

t=0:0.01:3;
%% parameters

s = 0.2:0.01:2;

%% find border between state 1 and 2

t1 = find(t==1);
t2 = find(t==2);

[A,c] = max(U);
U(1,c)

[A,I]=max(U(1,t1:t2));

b_max = t1+I-1;

U(1,b_max)

%% find minima of state 2

[U_min, b_min] = min(U(1,b_max:c));

b_min = b_min + b_max - 1;

%% Estimate probabilities
for i=1:length(s)
p1(i)  = sum(exp(-U(1,1:b_max)./s(i).^2))./sum(exp(-U(1,1:c)./s(i).^2));
p2(i)  = sum(exp(-U(1,b_max:c)./s(i).^2))./sum(exp(-U(1,1:c)./s(i).^2));
end

P = p2;


%% estimate mean duration of state 2

U_max = U(1,b_max);

% kramers escape rate
ddU = diff(diff(U));

ddU_min = ddU(b_min);
ddU_max = ddU(b_max);

t1_2 = 1./(2.*pi.*power(-ddU_min.*ddU_max,0.5)).*exp(2.*(U_max-U_min)./s.^2);

T1_2 = log(t1_2)-6;

%% plot distribution function
% subplot(1,2,1)
% plot(s,p2)
% subplot(1,2,2)
% plot(s,T1_2)

