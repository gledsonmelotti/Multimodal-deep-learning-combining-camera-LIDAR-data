clc
clear
close all

%% load data
load TrainVal_Remove_MIN_MAX_RI
load TrainVal_labels;
load TrainVal_predictDM;

%% Cy
CyIndex = TrainVal_labels == 2; % binary index for Cy labels
dmCy = TrainVal_Remove_MIN_MAX_RI(CyIndex);
predictCy = TrainVal_predictDM(CyIndex); predictCy = predictCy == 2;
gtCy = TrainVal_labels(CyIndex); gtCy = gtCy == 2;

% divide samples based on depth
spDivRIr = [5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80];

% usand range inverse
st.x_MEDIO = 5;   % movement direction
st.x_max = 80;
st.y_MEDIO = -80; % right
st.y_max = 80;  % left
dm = (st.x_max*(spDivRIr-st.x_MEDIO))./(spDivRIr*(st.x_max-st.x_MEDIO)); 
dm(dm < 0) = 0; dm(dm > 1) = 1;
spDivRI  = uint8(255*dm);

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
spDivRIr_DM_Cy=spDivRIr(1:end-1);
save spDivRIr_DM_Cy.mat spDivRIr_DM_Cy

FscoreCyI_DM = FscoreCyI;
% FscoreCyI_DM(5) = (FscoreCyI_DM(4)+FscoreCyI_DM(6))/2;
% FscoreCyI_DM(7) = (FscoreCyI_DM(6)+FscoreCyI_DM(8))/2;
% FscoreCyI_DM(2) = (FscoreCyI_DM(1)+FscoreCyI_DM(3))/2;
% FscoreCyI_DM(9) = (FscoreCyI_DM(8)+FscoreCyI_DM(10))/2;
save FscoreCyI_DM.mat FscoreCyI_DM

save PercCyc.mat PercCyc

hold on
plot(spDivRIr_DM_Cy, FscoreCyI_DM, '-g','LineWidth',2);
hold off
%xlim([5 80]); ylim([0 1]); 
grid on
xlabel('Distance (meter)','FontSize',12)
ylabel('F-score','FontSize',12)
legend({' Cy - RI'},'FontSize',12)


