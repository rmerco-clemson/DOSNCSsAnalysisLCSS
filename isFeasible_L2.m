function [dret,feasible] = isFeasible_L2(Ts,Td,dStart,gamma)
% look for a feasibility solution for a given Ts=Tsample(1+Delta),
% Td=selected Tmad, value of L2gain gamma, and starting selection for
% delta (dStart)

global Axx Axe Axw Aex Aee Aew C

%init return 
feasible = 0;
dret = -1;

%% LMI unknown variables definition

% matrix Pi for Lyapunov function 
nx = size(Axx,1);
P1 = sdpvar(nx,nx,'symmetric');
neta = size(Aex,1);
P20 = sdpvar(neta,neta,'symmetric');
P21 = sdpvar(neta,neta,'symmetric');
P30 = sdpvar(neta,neta,'symmetric');
P31 = sdpvar(neta,neta,'symmetric');

% iterations for evaluating different values of delta2 and delta3
for d=dStart:1:100 

    %LMIs
    M_01 = buildM_L2(P1,P21,P31,Axx,Axe,Axw,Aex,Aee,Aew,C,gamma,d,0);
    M_Td1 = buildM_L2(P1,P21,P31,Axx,Axe,Axw,Aex,Aee,Aew,C,gamma,d,Td);
    M_Td0 = buildM_L2(P1,P20,P30,Axx,Axe,Axw,Aex,Aee,Aew,C,gamma,d,Td);
    M_Ts0 = buildM_L2(P1,P20,P30,Axx,Axe,Axw,Aex,Aee,Aew,C,gamma,d,Ts);

    % Constraints
    WP1 = 1e-10*eye(size(P1));
    WP2 = 1e-10*eye(size(P20));
    WM = -1e-10*eye(size(M_01));
    Constraints = [P1>=WP1, P20>=WP2, P21>=WP2, P30>=WP2, P31>=WP2,...
          P21-exp(-d*Ts)*P20<=0, ...
          P20+P30-P31<=0, ...          
          M_01<=WM, M_Td1<=WM, M_Td0<=WM, M_Ts0<=WM];

    % optimization problem
    % Solve the feasibility problem
    Objective = [];
    options = sdpsettings('solver','sedumi','verbose',0,'cachesolvers',1);
    diagnostics = optimize(Constraints,Objective,options);

    % Analyze error flags
    if diagnostics.problem == 0
     disp('Solver thinks it is feasible: i=')             
     Ts
     Td
     dret = d
     feasible = 1
     return
    else
     disp('Something else happened')
     Ts
     Td
     d
    end
end  