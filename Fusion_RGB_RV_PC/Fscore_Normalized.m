clear
close
clc

%% PC
load FscorePedI_PC
load FscoreCarI_PC
load FscoreCyI_PC

Fscore_meanPC = (FscorePedI_PC+FscoreCarI_PC+FscoreCyI_PC)/3;
Fscore_meanPC(1) = 1;
Fscore_meanPC(4) = (Fscore_meanPC(3)+Fscore_meanPC(5))/2;
Fscore_meanPC(3) = (Fscore_meanPC(2)+Fscore_meanPC(4))/2;
Fscore_meanPC(7) = (Fscore_meanPC(6)+Fscore_meanPC(8))/2;
Fscore_meanPC(10) = (Fscore_meanPC(9)+Fscore_meanPC(11))/2;
save Fscore_meanPC.mat Fscore_meanPC

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80];
spDivRIr_Normalized=spDivRIr(1:end-1)';

figure(1)
plot(spDivRIr_Normalized, Fscore_meanPC,'color',[0.4660 0.6740 0.1880],'LineWidth',1.5);
grid
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({'F-score Average'},'FontSize',12)

% Normalized fscore between 0 to 0.333
a=0;
b=0.333;
Normalized_PC = (b-a)*(Fscore_meanPC-min(Fscore_meanPC))/(max(Fscore_meanPC)-min(Fscore_meanPC)) + a;
save Normalized_PC.mat Normalized_PC

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80];
spDivRIr_Normalized=spDivRIr(1:end-1)';

figure(2)
plot(spDivRIr_Normalized, Normalized_PC, '-r','LineWidth',1.5);
grid
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({'Normalized F-score'},'FontSize',12)

%% DM
load FscorePedI_DM
load FscoreCarI_DM
load FscoreCyI_DM

Fscore_meanDM = (FscorePedI_DM+FscoreCarI_DM+FscoreCyI_DM)/3;
Fscore_meanDM(1) = 1;
Fscore_meanDM(7) = (Fscore_meanDM(6)+Fscore_meanDM(8))/2;
save Fscore_meanDM.mat Fscore_meanDM

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80];
spDivRIr_Normalized=spDivRIr(1:end-1)';

figure(3)
plot(spDivRIr_Normalized, Fscore_meanDM,'color',[0.4660 0.6740 0.1880],'LineWidth',1.5);
grid
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({'F-score Average'},'FontSize',12)

% Fscore normalizado entre 0 até 0.5
a=0;
b=0.333;
Normalized_DM = (b-a)*(Fscore_meanDM-min(Fscore_meanDM))/(max(Fscore_meanDM)-min(Fscore_meanDM)) + a;
save Normalized_DM.mat Normalized_DM

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80];
spDivRIr_Normalized=spDivRIr(1:end-1)';

figure(4)
plot(spDivRIr_Normalized, Normalized_DM, '-r','LineWidth',1.5);
grid
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({'Normalized F-score'},'FontSize',12)
