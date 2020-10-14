clear all
clc

load FscorePedI_PC
load FscoreCarI_PC
load FscoreCyI_PC

% Smoothing the curve
Fscore_meanPC = (FscorePedI_PC+FscoreCarI_PC+FscoreCyI_PC)/3;
Fscore_meanPC(1) = 1;
Fscore_meanPC(4) = (Fscore_meanPC(3)+Fscore_meanPC(5))/2;
Fscore_meanPC(3) = (Fscore_meanPC(2)+Fscore_meanPC(4))/2;
Fscore_meanPC(7) = (Fscore_meanPC(6)+Fscore_meanPC(8))/2;
Fscore_meanPC(10) = (Fscore_meanPC(9)+Fscore_meanPC(11))/2;
save Fscore_meanPC.mat Fscore_meanPC

% Normalized fscore between 0 to 0.5
a=0;
b=0.5;
Normalized_PC = (b-a)*(Fscore_meanPC-min(Fscore_meanPC))/(max(Fscore_meanPC)-min(Fscore_meanPC)) + a;
save Normalized_PC.mat Normalized_PC

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80]; % You decide the values
spDivRIr_Normalized=spDivRIr(1:end-1)';

plot(spDivRIr_Normalized, Normalized_PC, '-g','LineWidth',2);
grid
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({' Normalized - RI'},'FontSize',12)