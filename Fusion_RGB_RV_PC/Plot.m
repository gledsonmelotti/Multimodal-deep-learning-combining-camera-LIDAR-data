clear
close
clc

load('spDivRIr_PC_Car.mat');
load('FscoreCarI_PC.mat');
load('FscorePedI_PC.mat');
load('FscoreCyI_PC.mat');
load('Fscore_medioPC.mat');
load('Normalized_PC.mat');

figure(1)
subplot(2,2,1);
plot(spDivRIr_PC_Car,FscoreCarI_PC,'color',[0 0.4470 0.7410],'LineWidth',1.5);
grid
legend({'Vehicles'},'FontSize',12)
xlabel('Distance (meters)')
ylabel('F-score (%)')
%title('Car DM')

subplot(2,2,2);
plot(spDivRIr_PC_Car,FscoreCyI_PC,'color',[0.8500 0.3250 0.0980],'LineWidth',1.5);
xlabel('Distance (meters)')
ylabel('F-score (%)')
grid
legend({'Cyclists'},'FontSize',12)
%title('Cyclist DM')

subplot(2,2,3);
plot(spDivRIr_PC_Car,FscorePedI_PC,'color',[0.9290 0.6940 0.1250],'LineWidth',1.5);
xlabel('Distance (meters)')
ylabel('F-score (%)')
grid
legend({'Pedestrians'},'FontSize',12)
%title('Pedestrian DM')

subplot(2,2,4);
plot(spDivRIr_PC_Car,Fscore_medioPC,'color',[0.4660 0.6740 0.1880],'LineWidth',1.5);
xlabel('Distance (meters)')
ylabel('F-score (%)')
legend({'F-score Average'},'FontSize',12)
grid
%title('Fscore Médio DM')

figure(2)
plot(spDivRIr_PC_Car,Normalized_PC,'-r','LineWidth',1.5);
legend('Normalized F-score')
xlabel('Distance (meters)')
ylabel('F-score (meters)')
grid
legend({'Normalized F-score'},'FontSize',12)
%title('Fscore Médio DM Normalizado')
