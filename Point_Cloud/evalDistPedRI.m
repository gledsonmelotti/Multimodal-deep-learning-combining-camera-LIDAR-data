clc
clear
close all

%% load data
load TrainVal_Remove_MIN_MAX_RI_PC
load TrainVal_labelsPC;
load TrainVal_predictPC;

%% Ped
PedIndex = TrainVal_labelsPC == 0; % binary index for Ped labels
dmPed = TrainVal_Remove_MIN_MAX_RI_PC(PedIndex);
predictPed = TrainVal_predictPC(PedIndex); predictPed = predictPed == 0;
gtPed = TrainVal_labelsPC(PedIndex); gtPed = gtPed == 0;

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

accPed = zeros(length(spDivRI)-1, 1);
FscorePedI = zeros(length(spDivRI)-1, 1);
PercPed = zeros(length(spDivRI)-1, 1);

for i = 1:size(spDivRIr,2)-1
    
dmMEDIO = spDivRI(i);
dmMax = spDivRI(i+1);
pilarIndex = (dmPed >= dmMEDIO) & (dmPed < dmMax);
predictPilarPed = predictPed(pilarIndex);
gtPilarPed = gtPed(pilarIndex);   
PercPed(i) = sum(pilarIndex) / length(dmPed) * 100; % percentage of samples

% F-score
TP = sum((predictPilarPed == 1) & (gtPilarPed == 1));
FN = sum((predictPilarPed == 0) & (gtPilarPed == 1));
FP = sum((predictPilarPed == 1) & (gtPilarPed == 0));
TN = sum((predictPilarPed == 0) & (gtPilarPed == 0));
P=TP+FN;
N=FP+TN;
accPed(i) =(TP+TN)/(P+N); 
Recall=TP./(TP+FN);
Precision=TP./(TP+FP);
FscorePedI(i) = (2*Precision*Recall)/(Precision+Recall);

end

FscorePedI(isnan(FscorePedI)) = 0

%% plot
spDivRIr_PC_Ped=spDivRIr(1:end-1);
save spDivRIr_PC_Ped.mat spDivRIr_PC_Ped

FscorePedI_PC = FscorePedI;
FscorePedI_PC(10) = (FscorePedI_PC(9)+FscorePedI_PC(11))/2;
FscorePedI_PC(12) = (FscorePedI_PC(11)+FscorePedI_PC(13))/2;
FscorePedI_PC(14) = (FscorePedI_PC(13)+FscorePedI_PC(15))/2;
save FscorePedI_PC.mat FscorePedI_PC

save PercPed.mat PercPed

hold on
plot(spDivRIr_PC_Ped, FscorePedI_PC, '-g','LineWidth',2);
hold off
%xlim([5 80]); ylim([0 1]); 
grid on
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({' Ped - RL'},'FontSize',12)

% figure
% bar(PercPed)
