%% this script creates the tradeoff curves for L2 stability
% define the plant and the controller
% define sampling time, L2 gain and performance output
% it saves a mat file with tradeoff curve and values of delta

clear all
close all
clc

% don't forget to install the solvers!!

tic
 
%% model known variables definition

global Axx Axe Axw Aex Aee Aew C

%batch reactor 

%Plant
Ap = [1.38 -0.2077 6.715 -5.676; 
      -0.5814 -4.29 0 0.675;
      1.067 4.273 -6.654 5.893;
      0.048 4.273 1.343 -2.104];
Bp = [0 0; 5.679 0; 1.136 -3.146; 1.136 0];
Cp = [1 0 1 -1; 0 1 0 0];
W = [10 0 10 0; 0 5 0 5]';

% controller
Ac = zeros(2,2); 
Bc = [0 1; 1 0];
Cc = -[2 0; 0 -8];
Dc = -[0 2; -5 0];

% sampling time and L2 gain
Tsample = 0.01; %sampling time
gamma = 5; %desired L2 gain

% performance output
C = [1 0 1 -1 0 0; 0 1 0 0 0 0];


%% compute matrices of the closed loop system

% xdot-x
Axx = [Ap+Bp*Dc*Cp Bp*Cc; Bc*Cp Ac];

% xdot-e
Axe = [Bp*Dc; Bc];

% xdot-omega
Axw = [W; zeros(size(Ac))];

% edot-x
Aex= -[Cp zeros(size(Cp,1),size(Ac,1))]*Axx;
 
%edot-e
Aee = -Cp*Bp*Dc;

% edot-omega
Aew = -Cp*W;


%% LMI Loop

%initializations
Delta = 0; %Delta init
stop = 0; %stop=1: stop while = problem not feasible

while (stop==0) 
    %for each Delta, we look for the maximium value of Tmad
    %while loop stops for the minimum value of Delta which gives not feasibility
    
    Ts = Tsample*(1+Delta); % transmission interval attempt
    TdVectFor = linspace(Tsample,0,10); %init grid for Tmad
    feasible = 0; %init var for feasibility check
    
    for j=1:length(TdVectFor) %looking for Tmad for each value of Delta
        
        Td = TdVectFor(j); %select value of Tmad 
        %looking for value of delta such that the problem is
        %feasible for the selected values of Delta and Tmad
        [dret,feasible] = isFeasible_L2(Ts,Td,1,gamma) 
        
        %if feasible assign the value to the output vectors
        if (feasible == 1)
            TsVect(Delta+1) = Ts; %vector for time of transmission attemps
            TdVect(Delta+1) = Td; %vector for Tmad 
            dVect(Delta+1) = dret; %vector for delta
            Delta = Delta+1;
            break; % feasibility found...move on with next Delta
        end
    end
    
    % if for loop concluded without finding condition for feasibility, 
    % interrupt the while
    if (feasible == 0)
        stop = 1;
    end
     
end

toc

%save mat file
filename = strcat('tradeoffCurvesDeltaTmad_L2_', strcat(num2str(gamma),'.mat'));
save(filename,'TsVect','TdVect','dVect')
    