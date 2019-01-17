function M = buildM_L2(P1,P2,P3,Axx,Axe,Axw,Aex,Aee,Aew,C,gamma,d,T)
%builds matrix inequality: Pi simmetric matrices of the Lyapunov function,
%Aij matrices of the hybrid systems, C performance output, gamma L2gain,
%d= delta, T= Tsample(1+Delta) or Tmad depending on the case

% simplier way of treating the exponentials
expV = exp(-d*T);

%define matrix element by element
M11 = Axx'*P1+P1*Axx + (C')*C;
M12 = P1*Axe+expV*Aex'*P2;
M13 = expV*Aex'*P3;
M14 = P1*Axw;
M21 = M12';
M22 = expV*(Aee'*P2+P2*Aee-d*P2);
M23 = expV*Aee'*P3;
M24 = expV*P2*Aew;
M31 = M13';
M32 = M23';
M33 = -expV*d*P3;
M34 = expV*P3*Aew;
M41 = M14';
M42 = M24';
M43 = M34';
M44 = -gamma^2*eye(size(M43,1),size(M34,1));

%put together the matrix
M=[M11 M12 M13 M14;
   M21 M22 M23 M24;
   M31 M32 M33 M34;
   M41 M42 M43 M44];
