Simulations require Yalmip with the solver SEDUMI. If those are needed:
- extract the folder 'solvers' from file 'solvers.rar'. 
- run the script 'install_solvers.m' to install both Yalmip and SEDUMI.

Script 'TradeOffDoS_Batch_L5.m' creates the tradeoff curves for the batch reactor for L2 gain less or equal to 5, see example in the paper.
Script 'TradeOffDoS_Batch_stability.m' creates the tradeoff curves for the batch reactor for the case of zero-input stability, see example in the paper.

'tradeoffCurvesDeltaTmad_L2_5_p.mat' and 'tradeoffCurvesDeltaTmad_stability_p.mat' are the saved tradeoff curves used to create the plot in the paper.
plots_tradeoffcurves.m creates the image of the tradeoff curves in the paper.