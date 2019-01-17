addpath('solvers/yalmip','solvers/yalmip/extras', ...
'solvers/yalmip/solvers','solvers/yalmip/modules',...
'solvers/yalmip/modules/parametric','solvers/yalmip/modules/moment',...
'solvers/yalmip/modules/global','solvers/yalmip/modules/robust',...
'solvers/yalmip/modules/sos','solvers/yalmip/operators');

clear classes;

cd solvers/sedumi
install_sedumi

cd ..
cd ..

yalmiptest