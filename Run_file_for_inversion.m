% Please run this file for inversion of simulated data into parameter space (synaptic connectivity). 
% Place this file and all function files (i.e. the .m files) in a folder in
% the Matlab pathway. 
% Include also the data file, "spm_2_data_T12.mat" The addresses in the
% files below will need to be altered depending on which folders the data
% and results will be kept. 

% Please cite the following paper "https://doi.org/10.48550/arXiv.2206.15158"

name = 'spm_2_data_T12'
computer = 'computer';

cd(['/Users/',computer,'/Google Drive/work 2021/codes/matlab2021/CMC_model/data'])

%% Clearing all previous information

spm('defaults','EEG');


%% Paths to data, etc.

    
Pbase     = ['/Users/',computer,'/Google Drive/work 2021/codes/matlab2021/CMC_model/data/']; 



Pdata     = Pbase ;                                                   % data directory in Pbase

mkdir([Pbase,'/DCM_review']);

Panalysis = [Pbase,'DCM_review'] ;                                   % analysis directory in Pbase


% the data

    DCM.xY.Dfile = [Pbase,name,'.mat'];




%% Parameters and options used for setting up model.

DCM.options.analysis = 'ERP';                                               % analyze evoked responses
DCM.options.model = 'T12_CMCperturb';                                                  % ERP model
DCM.options.spatial = 'LFP';                                                % spatial model


DCM.options.trials  = [1];                                                    % index of ERPs within ERP/ERF file
DCM.options.Tdcm(1) = 0;                                                    % start of peri-stimulus time to be modelled
DCM.options.Tdcm(2) = 1000;                                                  % end of peri-stimulus time to be modelled
DCM.options.Nmodes  = 1;                                                    % nr of modes for data selection
DCM.options.h       = 0;                                                    % nr of DCT components, detrending data
DCM.options.onset   = 0;                                                   % selection of onset (prior mean)
DCM.options.D       = 1;                                                    % downsampling
DCM.options.location =0;                                                    % Optimise dipole locations
DCM.options.symmetry =0;                                                    % Use symmetry constraint on dipoles
DCM.options.lock     =0;                                                    % Lock between trials
DCM.options.han      =0;                                                    % Use Hanning window on ERP signal

%% LFP model
DCM.Sname = {'LFP'};
Nareas    = 1;

%----------------------------------------------------------
%% Specify connectivity model

cd(Panalysis)

% Forward connection
DCM.A{1} = zeros(Nareas,Nareas);



% Backward connection
DCM.A{2} = zeros(Nareas,Nareas);


% Lateral connection
DCM.A{3} = zeros(Nareas,Nareas);

%----------------------------------------------------------
%% Speciyfing between trial effects
%----------------------------------------------------------
DCM.xU.X = [1];
DCM.xU.name = {'sound'};

%invert
%----------------------------------------------------------
DCM.name = ['DCM_data_T12_CMCperturb'];

DCM      = spm_dcm_csd_T12_CMCperturb(DCM);

return


