clc
clear all
close all

%% tradeoff curve - together
load tradeoffCurvesDeltaTmad_L2_5_p
DeltaXL2 = 0:length(TsVect)-1;
TdVectL2 = TdVect;

load tradeoffCurvesDeltaTmad_stability_p
DeltaXSta = 0:length(TsVect)-1;
TdVectSta = TdVect;

figure(1)
plot(DeltaXSta,TdVectSta,'h','MarkerSize',15,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r')
hold on
for i=1:length(DeltaXSta)
    plot([DeltaXSta(i) DeltaXSta(i)], [0 TdVectSta(i)],'r','linewidth',2)
end
plot(DeltaXL2,TdVectL2,'s','MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor','b')
for i=1:length(DeltaXL2)
    plot([DeltaXL2(i) DeltaXL2(i)], [0 TdVectL2(i)],'--b','linewidth',2)
end

hold off

grid
xlim([-0.2 2.2])
ylim([0 0.0105])
xlabel('\Delta')
ylabel('T_{mad} [s]')
% xlabel('x','interpreter','none')
% ylabel('y','interpreter','none')
set(gca,'FontSize',12, 'XTick', 0:4)
