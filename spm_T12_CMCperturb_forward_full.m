function D = spm_T12_CMCperturb_forward_full(P)% Create spectrum of ISI for parameter range
%clear ISI
% Parameters

%noise = 0.1:0.05:2.05;


%% estimate parameters for model

G = P.g;

%% run forward model


%D = probability_distribution_T1_2(G);
D = probability_distribution(G);
return

