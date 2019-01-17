function M = buildM_stability(P1,P2,P3,Axx,Axe,Aex,Aee,d,T)
%builds matrix inequality: Pi simmetric matrices of the Lyapunov function,
%Aij matrices of the hybrid systems,
%d= delta, T= Tsample(1+Delta) or Tmad depending on the case

% simplier way of treating the exponentials
expV = exp(-d*T);

%define matrix element by element
M11 = Axx'*P1+P1*Axx;
M12 = P1*Axe+expV*Aex'*P2;
M13 = expV*Aex'*P3;
M21 = M12';
M22 = expV*(Aee'*P2+P2*Aee-d*P2);
M23 = expV*Aee'*P3;
M31 = M13';
M32 = M23';
M33 = -expV*d*P3;

%put together the matrix
M=[M11 M12 M13;
   M21 M22 M23;
   M31 M32 M33];
