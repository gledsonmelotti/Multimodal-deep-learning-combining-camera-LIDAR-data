clc
clear
close all

%% load data
load TrainVal_Remove_MIN_MAX_RI_PC
load TrainVal_labelsPC;
load TrainVal_predictPC;

%% Cy
CyIndex = TrainVal_labelsPC == 2; % binary index for Cy labels
dmCy = TrainVal_Remove_MIN_MAX_RI_PC(CyIndex);
predictCy = TrainVal_predictPC(CyIndex); predictCy = predictCy == 2;
gtCy = TrainVal_labelsPC(CyIndex); gtCy = gtCy == 2;

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80];
%spDivRIr=linspace(5,80,100);
%spDivRIr = [5,20,35,50,65,80];
%spDivRIr = linspace(5,80,11);
% % usand range inverse
% st.x_MEDIO = 5;   % movement direction
% st.x_max = 80;
% st.y_MEDIO = -80; % right
% st.y_max = 80;  % left
% dm = (st.x_max*(spDivRIr-st.x_MEDIO))./(spDivRIr*(st.x_max-st.x_MEDIO)); 
% dm(dm < 0) = 0; dm(dm > 1) = 1;
% spDivRI  = uint8(255*dm);

spDivRI=spDivRIr;

accCy = zeros(length(spDivRI)-1, 1);
FscoreCyI = zeros(length(spDivRI)-1, 1);
PercCyc = zeros(length(spDivRI)-1, 1);

for i = 1:size(spDivRIr,2)-1
    
dmMEDIO = spDivRI(i);
dmMax = spDivRI(i+1);
pilarIndex = (dmCy >= dmMEDIO) & (dmCy < dmMax);
predictPilarCy = predictCy(pilarIndex);
gtPilarCy = gtCy(pilarIndex);   
PercCyc(i) = sum(pilarIndex) / length(dmCy) * 100; % percentage of samples
% 57.8117,    26.6056,    12.5700,     2.2595,     0.7532

% F-score
TP = sum((predictPilarCy == 1) & (gtPilarCy == 1));
FN = sum((predictPilarCy == 0) & (gtPilarCy == 1));
FP = sum((predictPilarCy == 1) & (gtPilarCy == 0));
TN = sum((predictPilarCy == 0) & (gtPilarCy == 0));
P=TP+FN;
N=FP+TN;
accCy(i) =(TP+TN)/(P+N); 
Recall=TP./(TP+FN);
Precision=TP./(TP+FP);
FscoreCyI(i) = (2*Precision*Recall)/(Precision+Recall);
end

FscoreCyI(isnan(FscoreCyI)) = 0

%% plot
spDivRIr_PC_Cy=spDivRIr(1:end-1);
save spDivRIr_PC_Cy.mat spDivRIr_PC_Cy

FscoreCyI_PC = FscoreCyI;
FscoreCyI_PC(9) = (FscoreCyI_PC(8)+FscoreCyI_PC(10))/2;
FscoreCyI_PC(14) = (FscoreCyI_PC(13)+FscoreCyI_PC(15))/2;
save FscoreCyI_PC.mat FscoreCyI_PC

save PercCyc.mat PercCyc

hold on
plot(spDivRIr_PC_Cy, FscoreCyI_PC, '-g','LineWidth',2);
hold off
%xlim([5 80]); ylim([0 1]); 
grid on
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({' Cy - RI'},'FontSize',12)


