clear
clc

% DM = RV: Depth Map = Range View

load FscorePedI_DM
load FscoreCarI_DM
load FscoreCyI_DM

Fscore_meanDM = (FscorePedI_DM+FscoreCarI_DM+FscoreCyI_DM)/3;
Fscore_meanDM(1) = 1;
Fscore_meanDM(7) = (Fscore_meanDM(6)+Fscore_meanDM(8))/2;
save Fscore_meanDM.mat Fscore_meanDM

% Normalized fscore between 0 to 0.5
a=0;
b=0.5;
Normalized_DM = (b-a)*(Fscore_meanDM-min(Fscore_meanDM))/(max(Fscore_meanDM)-min(Fscore_meanDM)) + a;
save Normalized_DM.mat Normalized_DM

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80]; % You decide the values
spDivRIr_Normalized=spDivRIr(1:end-1)';

plot(spDivRIr_Normalized, Normalized_DM, '-g','LineWidth',2);
grid
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({' Normalized - RI'},'FontSize',12)
